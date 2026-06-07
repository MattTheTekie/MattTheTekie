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

echo "Fetching GitHub repositories..."

repos='[]'
page=1

while true; do
    resp=$(curl -fsSL \
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

sync_repo() {
    repo_name="$1"

    echo "========================================"
    echo "Syncing: $repo_name"
    echo "========================================"

    mirror_path="${WORKDIR}/${repo_name}.git"
    rm -rf "$mirror_path"

    # -----------------------------
    # CLONE CLEAN SOURCE
    # -----------------------------
    if ! git clone --bare \
        "https://${GH_TOKEN}@github.com/${GH_USER}/${repo_name}.git" \
        "$mirror_path"; then
        echo "❌ Failed to clone $repo_name"
        return 0
    fi

    # -----------------------------
    # FETCH PRUNE (SAFE)
    # -----------------------------
    git -C "$mirror_path" fetch --prune origin || true

    # -----------------------------
    # REMOVE GITHUB PULL REQUEST REFS (SAFE LOOP)
    # -----------------------------
    while read -r ref; do
        [[ -n "$ref" ]] && git -C "$mirror_path" update-ref -d "$ref" || true
    done < <(
        git -C "$mirror_path" for-each-ref \
            --format='%(refname)' refs/pull 2>/dev/null || true
    )

    # -----------------------------
    # CODEBERG SETUP
    # -----------------------------
    codeberg_url="https://${CODEBERG_USER}:${CODEBERG_TOKEN}@codeberg.org/${CODEBERG_USER}/${repo_name}.git"

    git -C "$mirror_path" remote remove codeberg >/dev/null 2>&1 || true
    git -C "$mirror_path" remote add codeberg "$codeberg_url"

    # -----------------------------
    # GIT.GAY SETUP (OPTIONAL)
    # -----------------------------
    if [[ -n "$GITGAY_USER" && -n "$GITGAY_TOKEN" ]]; then
        gitgay_url="https://${GITGAY_USER}:${GITGAY_TOKEN}@git.gay/${GITGAY_USER}/${repo_name}.git"

        git -C "$mirror_path" remote remove gitgay >/dev/null 2>&1 || true
        git -C "$mirror_path" remote add gitgay "$gitgay_url"
    fi

    # -----------------------------
    # PUSH CLEAN REFS ONLY
    # -----------------------------
    git -C "$mirror_path" push --all codeberg || true
    git -C "$mirror_path" push --tags codeberg || true

    if [[ -n "$GITGAY_USER" && -n "$GITGAY_TOKEN" ]]; then
        git -C "$mirror_path" push --all gitgay || true
        git -C "$mirror_path" push --tags gitgay || true
    fi

    echo "✔ Done: $repo_name"
}

running=0

for ((i=0; i<repo_count; i++)); do
    repo_name=$(echo "$repos" | jq -r ".[$i].name")

    sync_repo "$repo_name" &

    ((running++))

    if (( running >= MAX_JOBS )); then
        wait -n || true
        ((running--))
    fi
done

wait

echo "========================================"
echo "ALL REPOSITORIES SYNCED SUCCESSFULLY"
echo "========================================"
