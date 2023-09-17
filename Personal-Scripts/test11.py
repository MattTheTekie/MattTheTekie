import os
import re
from datetime import datetime
import chardet

# Function to convert Unix timestamp to the desired date format
def unix_timestamp_to_date(match):
    timestamp = int(match.group(1))
    date = datetime.utcfromtimestamp(timestamp).strftime('%Y-%m-%d')
    return f'summary: "{date}"\npublishedAt: "{date}"'

# Function to update YAML front matter
def update_yaml_front_matter(file_path):
    with open(file_path, 'rb') as file:
        # Detect the character encoding of the file
        encoding_info = chardet.detect(file.read())

    # Reopen the file with the detected encoding for reading
    with open(file_path, 'r', encoding=encoding_info['encoding'], errors='ignore') as file:
        content = file.read()
    
    # Check for valid UTF-8 encoding
    try:
        content.encode('utf-8').decode('utf-8')
    except UnicodeDecodeError:
        print(f"Skipping file {file_path}. Invalid UTF-8 encoding.")
        return

    with open(file_path, 'w', encoding=encoding_info['encoding']) as file:
        # Replace Unix timestamps with the desired date format in summary and publishedAt
        content = re.sub(r'date: (\d+)', unix_timestamp_to_date, content)
        
        # Remove extra "summary" containing a date and the extra empty line
        content = re.sub(r'summary: "(\d{4}-\d{2}-\d{2})"\n', '', content)

        # Correct "publishedAt" values like "1970-01-01"-05-30T11:08:30+08:00
        content = re.sub(r'publishedAt: "(\d{4}-\d{2}-\d{2})"-(\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\+\d{2}:\d{2})', r'publishedAt: "\1\2"', content)

        # Add summary field if it doesn't exist
        content = re.sub(r'title: "([^"]+)"', r'title: "\1"\nsummary: "\1"', content)

        file.write(content)

# Get a list of all files with YAML front matter
files_with_yaml_front_matter = [file for file in os.listdir() if file.endswith('.md')]

# Process each file
for file_name in files_with_yaml_front_matter:
    update_yaml_front_matter(file_name)

print("YAML front matter updated in .md files with the desired structure and extra empty lines removed.")
