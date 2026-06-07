#!/usr/bin/env bash
set -euo pipefail

: "${GH_USER:?Missing GH_USER}"
: "${GH_TOKEN:?Missing GH_TOKEN}"
: "${CODEBERG_USER:?Missing CODEBERG_USER}"
: "${CODEBERG_TOKEN:?Missing CODEBERG_TOKEN}"

WORKDIR="./mirrors"
mkdir -p "$WORKDIR"

MAX_JOBS=5   # adjust (3–10 is safe in GitHub Actions)

echo "Fetching GitHub repositories..."

github_repos='[]'
page=1

while true; do
    resp=$(curl -fsSL \
        -H "Authorization: Bearer ${GH_TOKEN}" \
        "https://api.github.com/user/repos?per_page=100&type=owner&page=${page}")

    count=$(echo "$resp" | jq length)

    [[ "$count" -eq 0 ]] && break

    github_repos=$(jq -s 'add' <(echo "$github_repos") <(echo "$resp"))

    echo "Fetched page $page ($count repos)"
    ((page++))
done

repo_count=$(echo "$github_repos" | jq length)

echo "Total repos: $repo_count"

# -------------------------------
# FUNCTION: sync one repo
# -------------------------------
sync_repo() {
    repo_name="$1"
    repo_private="$2"

    echo ">>> Syncing $repo_name"

    mirror_path="${WORKDIR}/${repo_name}.git"

    # Always fresh clone (safe in CI)
    rm -rf "$mirror_path"

    git clone --mirror \
        "https://${GH_TOKEN}@github.com/${GH_USER}/${repo_name}.git" \
        "$mirror_path"

    codeberg_url="https://${CODEBERG_USER}:${CODEBERG_TOKEN}@codeberg.org/${CODEBERG_USER}/${repo_name}.git"

    git -C "$mirror_path" remote remove codeberg >/dev/null 2>&1 || true
    git -C "$mirror_path" remote add codeberg "$codeberg_url"

    git -C "$mirror_path" push --mirror codeberg

    echo "<<< Done $repo_name"
}

# -------------------------------
# PARALLEL EXECUTION
# -------------------------------
running=0

for ((i=0; i<repo_count; i++)); do
    repo_name=$(echo "$github_repos" | jq -r ".[$i].name")
    repo_private=$(echo "$github_repos" | jq -r ".[$i].private")

    sync_repo "$repo_name" "$repo_private" &

    ((running++))

    if (( running >= MAX_JOBS )); then
        wait -n   # wait for any job to finish
        ((running--))
    fi
done

wait

echo "All repositories synced successfully."
