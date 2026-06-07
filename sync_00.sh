#!/usr/bin/env bash
set -euo pipefail

: "${GH_USER:?Missing GH_USER}"
: "${GH_TOKEN:?Missing GH_TOKEN}"
: "${CODEBERG_USER:?Missing CODEBERG_USER}"
: "${CODEBERG_TOKEN:?Missing CODEBERG_TOKEN}"

GITGAY_USER="${GITGAY_USER:-}"
GITGAY_TOKEN="${GITGAY_TOKEN:-}"

WORKDIR="./mirrors"
rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"

MAX_JOBS=5

# =====================================================
# GITHUB API WRAPPER WITH RATE-LIMIT HANDLING
# =====================================================

api_get() {
local url="$1"
local attempt=0
local max_attempts=6

while (( attempt < max_attempts )); do
    response=$(curl -i -s \
        -H "Authorization: Bearer ${GH_TOKEN}" \
        "$url")

    http_code=$(echo "$response" | head -n 1 | awk '{print $2}')
    body=$(echo "$response" | sed -n '/^\r$/,$p' | sed '1d')

    remaining=$(echo "$response" | grep -i "X-RateLimit-Remaining" | awk '{print $2}' | tr -d '\r')
    reset=$(echo "$response" | grep -i "X-RateLimit-Reset" | awk '{print $2}' | tr -d '\r')

    if [[ "$http_code" == "200" ]]; then
        echo "$body"
        return 0
    fi

    if [[ "$http_code" == "403" && "$remaining" == "0" ]]; then
        now=$(date +%s)
        sleep_time=$((reset - now))
        sleep_time=$(( sleep_time > 0 ? sleep_time : 5 ))
        echo "⏳ GitHub rate limit hit — sleeping ${sleep_time}s"
        sleep "$sleep_time"
        continue
    fi

    echo "⚠️ GitHub API error $http_code — retrying in $((2**attempt))s"
    sleep $((2**attempt))
    ((attempt++))
done

echo "❌ GitHub API failed after $max_attempts attempts"
return 1
}

# =====================================================
# FETCH ALL GITHUB REPOS
# =====================================================

echo "Fetching GitHub repositories..."

repos='[]'
page=1

while true; do
resp=$(api_get "https://api.github.com/user/repos?per_page=100&type=owner&page=${page}")
count=$(echo "$resp" | jq length)

[[ "$count" -eq 0 ]] && break

repos=$(jq -s 'add' <(echo "$repos") <(echo "$resp"))
echo "Fetched page $page ($count repos)"

sleep 0.4
((page++))
done

repo_count=$(echo "$repos" | jq length)
echo "Total repos: $repo_count"

# =====================================================
# CREATE CODEBERG REPO
# =====================================================

ensure_codeberg_repo() {
local name="$1"
local private="$2"

status=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "Authorization: token ${CODEBERG_TOKEN}" \
    "https://codeberg.org/api/v1/repos/${CODEBERG_USER}/${name}")

if [[ "$status" == "404" ]]; then
    echo "📦 Creating Codeberg repo: $name"
    curl -fsSL -X POST \
        -H "Authorization: token ${CODEBERG_TOKEN}" \
        -H "Content-Type: application/json" \
        "https://codeberg.org/api/v1/user/repos" \
        -d "$(jq -n \
            --arg name "$name" \
            --argjson private "$private" \
            '{name:$name, private:$private}')" \
        >/dev/null || true
fi
}

# =====================================================
# CREATE GIT.GAY REPO
# =====================================================

ensure_gitgay_repo() {
local name="$1"
local private="$2"

[[ -z "$GITGAY_USER" || -z "$GITGAY_TOKEN" ]] && return 0

status=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "Authorization: token ${GITGAY_TOKEN}" \
    "https://git.gay/api/v1/repos/${GITGAY_USER}/${name}")

if [[ "$status" == "404" ]]; then
    echo "📦 Creating git.gay repo: $name"
    curl -fsSL -X POST \
        -H "Authorization: token ${GITGAY_TOKEN}" \
        -H "Content-Type: application/json" \
        "https://git.gay/api/v1/user/repos" \
        -d "$(jq -n \
            --arg name "$name" \
            --argjson private "$private" \
            '{name:$name, private:$private}')" \
        >/dev/null || true
fi
}

# =====================================================
# SYNC FUNCTION
# =====================================================

sync_repo() {
local repo_name="$1"
local repo_private="$2"

{
    echo "========================================"
    echo "Syncing: $repo_name"
    echo "========================================"

    mirror_path="${WORKDIR}/${repo_name}.git"
    rm -rf "$mirror_path"

    if ! git clone --bare \
        "https://${GH_TOKEN}@github.com/${GH_USER}/${repo_name}.git" \
        "$mirror_path"; then
        echo "❌ Clone failed: $repo_name"
        return 0
    fi

    git -C "$mirror_path" fetch --prune origin || true

    while read -r ref; do
        [[ -n "$ref" ]] && git -C "$mirror_path" update-ref -d "$ref" || true
    done < <(git -C "$mirror_path" for-each-ref --format='%(refname)' refs/pull 2>/dev/null || true)

    ensure_codeberg_repo "$repo_name" "$repo_private"
    ensure_gitgay_repo "$repo_name" "$repo_private"

    codeberg_url="https://${CODEBERG_USER}:${CODEBERG_TOKEN}@codeberg.org/${CODEBERG_USER}/${repo_name}.git"
    git -C "$mirror_path" remote remove codeberg >/dev/null 2>&1 || true
    git -C "$mirror_path" remote add codeberg "$codeberg_url"

    if [[ -n "$GITGAY_USER" && -n "$GITGAY_TOKEN" ]]; then
        gitgay_url="https://${GITGAY_USER}:${GITGAY_TOKEN}@git.gay/${GITGAY_USER}/${repo_name}.git"
        git -C "$mirror_path" remote remove gitgay >/dev/null 2>&1 || true
        git -C "$mirror_path" remote add gitgay "$gitgay_url"
    fi

    git -C "$mirror_path" push --all codeberg || true
    git -C "$mirror_path" push --tags codeberg || true

    if [[ -n "$GITGAY_USER" && -n "$GITGAY_TOKEN" ]]; then
        git -C "$mirror_path" push --all gitgay || true
        git -C "$mirror_path" push --tags gitgay || true
    fi

    echo "✔ Done: $repo_name"

} || {
    echo "⚠️ Failed repo (non-fatal): $repo_name"
}
}

# =====================================================
# PARALLEL EXECUTION — ONLY SYNC "mattthetekie"
# =====================================================

pids=()

for ((i=0; i<repo_count; i++)); do
    repo_name=$(echo "$repos" | jq -r ".[$i].name")
    repo_private=$(echo "$repos" | jq -r ".[$i].private")

    # Only sync this one repo
    if [[ "$repo_name" != "mattthetekie" ]]; then
        continue
    fi

    sync_repo "$repo_name" "$repo_private" &
    pids+=("$!")

    if (( ${#pids[@]} >= MAX_JOBS )); then
        for pid in "${pids[@]}"; do wait "$pid" || true; done
        pids=()
    fi
done

for pid in "${pids[@]}"; do wait "$pid" || true; done

echo "========================================"
echo "ONLY 'mattthetekie' SYNCED SUCCESSFULLY"
echo "========================================"
exit 0
