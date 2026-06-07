#!/usr/bin/env bash
set -euo pipefail

: "${GH_USER:?Missing GH_USER}"
: "${GH_TOKEN:?Missing GH_TOKEN}"
: "${CODEBERG_USER:?Missing CODEBERG_USER}"
: "${CODEBERG_TOKEN:?Missing CODEBERG_TOKEN}"

GITGAY_USER="${GITGAY_USER:-}"
GITGAY_TOKEN="${GITGAY_TOKEN:-}"

: "${VELTRON_USER:?Missing VELTRON_USER}"
: "${VELTRON_TOKEN:?Missing VELTRON_TOKEN}"

WORKDIR="./mirrors"
rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"

MAX_JOBS=5

echo "Fetching GitHub repositories..."

repos='[]'
page=1

while true; do
    resp=$(curl --silent --show-error --fail \
        --connect-timeout 10 \
        --max-time 30 \
        -H "Authorization: Bearer ${GH_TOKEN}" \
        "https://api.github.com/user/repos?per_page=100&type=owner&page=${page}")

    count=$(echo "$resp" | jq length)
    [[ "$count" -eq 0 ]] && break

    repos=$(jq -s 'add' <(echo "$repos") <(echo "$resp"))

    echo "Fetched page $page ($count repos)"
    ((page++))
done

repo_count=$(echo "$repos" | jq length)
echo "Total repos: $repo_count"

# =====================================================
# GIT.GAY
# =====================================================

ensure_gitgay_repo() {
    local name="$1"
    local private="$2"

    [[ -z "$GITGAY_USER" || -z "$GITGAY_TOKEN" ]] && return 0

    status=$(curl --silent --connect-timeout 10 --max-time 20 \
        -o /dev/null -w "%{http_code}" \
        -H "Authorization: token ${GITGAY_TOKEN}" \
        "https://git.gay/api/v1/repos/${GITGAY_USER}/${name}")

    if [[ "$status" == "404" ]]; then
        echo "📦 Creating git.gay repo: $name"

        curl --silent --show-error --fail \
            --connect-timeout 10 \
            --max-time 30 \
            -X POST \
            -H "Authorization: token ${GITGAY_TOKEN}" \
            -H "Content-Type: application/json" \
            "https://git.gay/api/v1/user/repos" \
            -d "$(jq -n --arg name "$name" --argjson private "$private" '{name:$name, private:$private}')" \
            >/dev/null || true
    fi
}

# =====================================================
# GIT.VELTRON.NET
# =====================================================

ensure_veltron_repo() {
    local name="$1"
    local private="$2"

    # Convert GitHub's "true"/"false" to real JSON booleans
    if [[ "$private" == "true" ]]; then
        private_bool=true
    else
        private_bool=false
    fi

    status=$(curl --silent --connect-timeout 10 --max-time 20 \
        -o /dev/null -w "%{http_code}" \
        -H "Authorization: Bearer ${VELTRON_TOKEN}" \
        "https://git.veltron.net/api/v1/repos/${VELTRON_USER}/${name}")

    if [[ "$status" == "404" ]]; then
        echo "📦 Creating git.veltron.net repo: $name (private=$private_bool)"

        curl --silent --show-error --fail \
            --connect-timeout 10 \
            --max-time 30 \
            -X POST \
            -H "Authorization: Bearer ${VELTRON_TOKEN}" \
            -H "Content-Type: application/json" \
            "https://git.veltron.net/api/v1/user/repos" \
            -d "$(jq -n --arg name "$name" --argjson private "$private_bool" '{name:$name, private:$private}')" \
            >/dev/null || true
    fi
}


# =====================================================
# SYNC
# =====================================================

sync_repo() {
{
    local repo_name="$1"
    local repo_private="$2"

    echo "========================================"
    echo "Syncing: $repo_name"
    echo "========================================"

    mirror_path="${WORKDIR}/${repo_name}.git"
    rm -rf "$mirror_path"

    # Clone
    if ! git clone --bare \
        "https://${GH_TOKEN}@github.com/${GH_USER}/${repo_name}.git" \
        "$mirror_path"; then
        echo "❌ Clone failed: $repo_name"
        return 0
    fi

    git -C "$mirror_path" fetch --prune origin || true

    # Clean PR refs
    while read -r ref; do
        [[ -n "$ref" ]] && git -C "$mirror_path" update-ref -d "$ref" || true
    done < <(
        git -C "$mirror_path" for-each-ref --format='%(refname)' refs/pull 2>/dev/null || true
    )

    # Ensure remotes exist
    ensure_gitgay_repo "$repo_name" "$repo_private" || true
    ensure_veltron_repo "$repo_name" "$repo_private" || true
    
    # git.gay remote
    if [[ -n "$GITGAY_USER" && -n "$GITGAY_TOKEN" ]]; then
        gitgay_url="https://${GITGAY_USER}:${GITGAY_TOKEN}@git.gay/${GITGAY_USER}/${repo_name}.git"
        git -C "$mirror_path" remote remove gitgay >/dev/null 2>&1 || true
        git -C "$mirror_path" remote add gitgay "$gitgay_url"
        git -C "$mirror_path" push --all gitgay || true
        git -C "$mirror_path" push --tags gitgay || true
    fi

    # veltron remote
    veltron_url="https://${VELTRON_USER}:${VELTRON_TOKEN}@git.veltron.net/${VELTRON_USER}/${repo_name}.git"
    git -C "$mirror_path" remote remove veltron >/dev/null 2>&1 || true
    git -C "$mirror_path" remote add veltron "$veltron_url"
    git -C "$mirror_path" push --all veltron || true
    git -C "$mirror_path" push --tags veltron || true

    echo "✔ Done: $repo_name"

} || {
    echo "⚠️ Failed repo (non-fatal): $repo_name"
}
}

# =====================================================
# PARALLEL EXECUTION
# =====================================================

pids=()

for ((i=0; i<repo_count; i++)); do
    repo_name=$(echo "$repos" | jq -r ".[$i].name")
    repo_private=$(echo "$repos" | jq -r ".[$i].private")

    sync_repo "$repo_name" "$repo_private" &
    pids+=("$!")

    if (( ${#pids[@]} >= MAX_JOBS )); then
        for pid in "${pids[@]}"; do
            wait "$pid" || true
        done
        pids=()
    fi
done

for pid in "${pids[@]}"; do
    wait "$pid" || true
done

echo "========================================"
echo "ALL REPOSITORIES SYNCED SUCCESSFULLY"
echo "========================================"

# =====================================================
# SPECIAL: mattthetekie → Codeberg
# =====================================================

echo "========================================"
echo "PUSHING mattthetekie → Codeberg"
echo "========================================"

single_repo="mattthetekie"
mirror_path="${WORKDIR}/${single_repo}.git"

rm -rf "$mirror_path"

if git clone --bare \
    "https://${GH_TOKEN}@github.com/${GH_USER}/${single_repo}.git" \
    "$mirror_path"; then

    git -C "$mirror_path" fetch --prune origin || true

    codeberg_url="https://${CODEBERG_USER}:${CODEBERG_TOKEN}@codeberg.org/${CODEBERG_USER}/${single_repo}.git"
    git -C "$mirror_path" remote remove codeberg >/dev/null 2>&1 || true
    git -C "$mirror_path" remote add codeberg "$codeberg_url"

    git -C "$mirror_path" push --mirror codeberg || true

    echo "✔ Successfully pushed mattthetekie → Codeberg"
else
    echo "❌ Failed to clone mattthetekie"
fi
