#!/usr/bin/env bash
set -euo pipefail

: "${GITHUB_USER:?Missing GITHUB_USER}"
: "${GITHUB_TOKEN:?Missing GITHUB_TOKEN}"
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
        -H "Authorization: Bearer ${GITHUB_TOKEN}" \
        "https://api.github.com/user/repos?per_page=100&type=owner&page=${page}")

    count=$(echo "$resp" | jq length)

    [[ "$count" -eq 0 ]] && break

    github_repos=$(jq -s 'add' <(echo "$github_repos") <(echo "$resp"))

    echo "Fetched page $page ($count repos)"
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

    echo "----------------------------------------"
    echo "Syncing: $repo_name"
    echo "----------------------------------------"

    exists=$(echo "$codeberg_repos" | jq -r --arg n "$repo_name" '
        .[] | select(.name == $n) | .name
    ' | head -n1)

    if [[ -z "$exists" ]]; then
        echo "Creating repo on Codeberg..."

        curl -fsSL -X POST \
            -H "Authorization: token ${CODEBERG_TOKEN}" \
            -H "Content-Type: application/json" \
            https://codeberg.org/api/v1/user/repos \
            -d "$(jq -n --arg name "$repo_name" --argjson private "$repo_private" \
            '{name:$name, private:$private}')" >/dev/null
    fi

    mirror_path="${WORKDIR}/${repo_name}.git"

    echo "Cloning mirror..."
    git clone --mirror \
        "https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${repo_name}.git" \
        "$mirror_path"

    codeberg_url="https://${CODEBERG_USER}:${CODEBERG_TOKEN}@codeberg.org/${CODEBERG_USER}/${repo_name}.git"

    git -C "$mirror_path" remote add codeberg "$codeberg_url" || \
    git -C "$mirror_path" remote set-url codeberg "$codeberg_url"

    echo "Pushing to Codeberg..."
    git -C "$mirror_path" push --mirror codeberg

    echo "Done: $repo_name"
done

echo "All repositories synced successfully."
