#!/bin/bash

# Set the organization name
ORG_NAME="venithnet"

# Set the output directory
OUTPUT_DIR="output_contributors"

# Fetch repositories from GitHub API
REPOS=($(curl -s "https://api.github.com/orgs/$ORG_NAME/repos" | jq -r '.[].name'))

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop through each repository
for REPO in "${REPOS[@]}"; do
  # Create a directory for each repository
  REPO_DIR="$OUTPUT_DIR/$REPO"
  mkdir -p "$REPO_DIR"

  echo "Downloading contributor images from $REPO to $REPO_DIR..."

  # Set the URL of the file to download for each repository
  IMAGE_URL="https://contrib.rocks/image?repo=$ORG_NAME/$REPO"

  # Download the image and save it in the repository directory
  curl -s "$IMAGE_URL" > "$REPO_DIR/contributor_$REPO.svg"
done

echo "Contributor images downloaded and saved to $OUTPUT_DIR"

# Set the input folder containing SVG files
INPUT_FOLDER="output_contributors"

# Set the output file name
OUTPUT_FILE="contributors.svg"

# Create an empty SVG file with XML declaration
echo "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>" > "$OUTPUT_FILE"
echo "<svg xmlns=\"http://www.w3.org/2000/svg\">" >> "$OUTPUT_FILE"

# Concatenate SVG files into the output file recursively
find "$INPUT_FOLDER" -type f -name "*.svg" | while IFS= read -r SVG_FILE; do
  # Skip the XML declaration and opening svg tag for subsequent files
  tail -n +3 "$SVG_FILE" | grep -v '<svg xmlns="http://www.w3.org/2000/svg">' >> "$OUTPUT_FILE"
  echo -e "\n<!-- Separator for $SVG_FILE -->\n" >> "$OUTPUT_FILE"
done

# Close the SVG element
echo "</svg>" >> "$OUTPUT_FILE"

echo "SVG files in $INPUT_FOLDER and its subdirectories merged and saved to $OUTPUT_FILE"

rm output_contributors -rf