#!/bin/bash

ORG_NAME="VENITHNET"
README_FILE="README.md"
GITHUB_TOKEN="$${{ secrets.GITHUB_TOKEN }}"

# Get the list of repositories from the GitHub API with your GitHub Access Token
repositories=$(curl -s -H "Authorization: bearer $GITHUB_TOKEN" "https://api.github.com/orgs/$ORG_NAME/repos?per_page=100" | jq -r '.[].contributors_url')

# Initialize an array to store unique contributors
unique_contributors=()

# Loop through each repository's contributors and add to the array
for contributor_url in $repositories; do
    repo_contributors=$(curl -s -H "Authorization: bearer $GITHUB_TOKEN" "$contributor_url" | jq -r '.[].login')
    unique_contributors+=($repo_contributors)
done

# Use sort and uniq to remove duplicates
unique_contributors=($(echo "${unique_contributors[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

# Count the total number of unique contributors
total_contributors=${#unique_contributors[@]}

# Create the badge URL with the actual number of contributors
badge_url="https://img.shields.io/badge/contributors-$total_contributors%20contributors-yellow.svg"

# Echo the badge URL
echo "Badge URL: $badge_url"

# Replace existing contributors badge URL in README file using sed
sed -i "s|https://img.shields.io/github/contributors/$ORG_NAME/VENITH.NET|$badge_url|g" "$README_FILE"

echo "Badge URL replaced in $README_FILE"
