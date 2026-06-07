#!/usr/bin/env bash
set -euo pipefail

: "${GH_USER:?Missing GH_USER}"
: "${GH_TOKEN:?Missing GH_TOKEN}"
: "${CODEBERG_USER:?Missing CODEBERG_USER}"
: "${CODEBERG_TOKEN:?Missing CODEBERG_TOKEN}"

WORKDIR="./mirrors"
rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"

echo "Fetching GitHub repositories..."

github_repos='[]'
page=1

while true; do
    resp=$(curl -fsSL \
        -H "Authorization: Bearer ${GH_TOKEN}" \
        "https://api.github.com/user/repos?per_page=100&type=owner&page=${page}")

    count=$(echo "$resp" | jq length)

    if [[ "$count" -eq 0 ]]; then
        break
    fi

    github_repos=$(jq -s 'add' <(echo "$github_repos") <(echo "$resp"))

    echo "Fetched GitHub page $page ($count repos)"
    ((page++))
done

echo "Fetching Codeberg repositories..."

codeberg_repos=$(curl -fsSL \
    -H "Authorization: token ${CODEBERG_TOKEN}" \
    "https://codeberg.org/api/v1/user/repos?limit=1000")

repo_count=$(echo "$github_repos" | jq length)

echo "Total GitHub repos: $repo_count"

for ((i=0; i<repo_count; i++)); do
    repo_name=$(echo "$github_repos" | jq -r ".[$i].name")
    repo_private=$(echo "$github_repos" | jq -r ".[$i].private")

    echo
    echo "========================================"
    echo "Syncing: $repo_name"
    echo "========================================"

    exists=$(echo "$codeberg_repos" | jq -r --arg n "$repo_name" '
        .[] | select(.name == $n) | .name
    ' | head -n1)

    if [[ -z "$exists" ]]; then
        echo "Creating repo on Codeberg..."

        curl -fsSL -X POST \
            -H "Authorization: token ${CODEBERG_TOKEN}" \
            -H "Content-Type: application/json" \
            https://codeberg.org/api/v1/user/repos \
            -d "$(jq -n \
                --arg name "$repo_name" \
                --argjson private "$repo_private" \
                '{name:$name, private:$private}')" >/dev/null

        echo "Repository created."
    else
        echo "Repository already exists."
    fi

    mirror_path="${WORKDIR}/${repo_name}.git"

    echo "Cloning fresh mirror..."
    git clone --mirror \
        "https://${GH_TOKEN}@github.com/${GH_USER}/${repo_name}.git" \
        "$mirror_path"

    codeberg_url="https://${CODEBERG_USER}:${CODEBERG_TOKEN}@codeberg.org/${CODEBERG_USER}/${repo_name}.git"

    if git -C "$mirror_path" remote get-url codeberg >/dev/null 2>&1; then
        git -C "$mirror_path" remote set-url codeberg "$codeberg_url"
    else
        git -C "$mirror_path" remote add codeberg "$codeberg_url"
    fi

    echo "Pushing mirror to Codeberg..."
    git -C "$mirror_path" push --mirror codeberg

    echo "Done: $repo_name"
done

echo
echo "All repositories synced successfully."
