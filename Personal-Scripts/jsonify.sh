#!/bin/bash

# Replace with the desired GitHub username
username="MattTheTekie"

url="https://api.github.com/users/$username/repos"
response=$(curl -s "$url")

if [ -z "$response" ]; then
    echo "Failed to fetch repositories."
    exit 1
fi

result="["
first=true

while IFS= read -r line; do
    if [[ $line == *"full_name"* ]]; then
        full_name=$(echo "$line" | cut -d'"' -f4)
    elif [[ $line == *"name"* ]]; then
        name=$(echo "$line" | cut -d'"' -f4)
    elif [[ $line == *"html_url"* ]]; then
        html_url=$(echo "$line" | cut -d'"' -f4)
    elif [[ $line == *"description"* ]]; then
        description=$(echo "$line" | cut -d'"' -f4)
    elif [[ $line == *"homepage"* ]]; then
        homepage=$(echo "$line" | cut -d'"' -f4)
    elif [[ $line == *"login"* ]]; then
        login=$(echo "$line" | cut -d'"' -f4)
    elif [[ $line == *"avatar_url"* ]]; then
        avatar_url=$(echo "$line" | cut -d'"' -f4)
    elif [[ $line == *"stargazers_count"* ]]; then
        stargazers_count=$(echo "$line" | cut -d':' -f2)
    elif [[ $line == *"language"* ]]; then
        language=$(echo "$line" | cut -d'"' -f4)

        if [ "$first" = true ]; then
            result+="[\"$full_name\",{\"name\":\"$name\",\"html_url\":\"$html_url\",\"description\":\"$description\",\"homepage\":\"$homepage\",\"owner\":{\"login\":\"$login\",\"avatar_url\":\"$avatar_url\"},\"stargazers_count\":$stargazers_count,\"language\":\"$language\"}]"
            first=false
        else
            result+=",[\"$full_name\",{\"name\":\"$name\",\"html_url\":\"$html_url\",\"description\":\"$description\",\"homepage\":\"$homepage\",\"owner\":{\"login\":\"$login\",\"avatar_url\":\"$avatar_url\"},\"stargazers_count\":$stargazers_count,\"language\":\"$language\"}]"
        fi
    fi
done <<< "$response"

# Close the array
result+="]"

# Replace newlines with spaces for pretty printing
result="${result//$'\n'/ }"

# Print the result
echo "$result"
