import requests
import re
import os

# Function to download files using requests
def download_file(url, filename):
    response = requests.get(url, stream=True)
    if response.status_code == 200:
        with open(filename, "wb") as file:
            file.write(response.content)
        print(f"✅ Downloaded: {filename}")
    else:
        print(f"❌ Failed to download: {url}")

# Function to clean and rename M3U files with prefix and group-title
def clean_and_rename_m3u(input_file, output_file, prefix):
    with open(input_file, "r", encoding="utf-8") as f:
        content = f.read()

    content = re.sub(r"[\[\(].*?[\]\)]", "", content)
    group_title = "Japanese TV" if prefix == "[JAPAN]" else prefix.strip("[]")
    content = re.sub(r'group-title=".*?"', f'group-title="{group_title}"', content)
    content = re.sub(r'(#EXTINF:-1\s*)(?!.*group-title)', rf'\1group-title="{group_title}" ', content)
    content = re.sub(r'(#EXTINF[^,]*,)(.*)', rf'\1 {prefix} \2', content)

    with open(output_file, "w", encoding="utf-8") as f:
        f.write(content)

# Function to clean VENITH only (remove brackets/parentheses)
def clean_venith_m3u(input_file, output_file):
    with open(input_file, "r", encoding="utf-8") as f:
        content = f.read()
    content = re.sub(r'(#EXTINF[^,]*,)(.*)', lambda m: m.group(1) + re.sub(r"[\[\(].*?[\]\)]", "", m.group(2)), content)
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(content)

# --- Step 1: Download IPTV Files ---
jp_file = {"jp_org.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/master/streams/jp.m3u"}
free_tv_files = {
    "plex.m3u": "https://github.com/BuddyChewChew/app-m3u-generator/raw/refs/heads/main/playlists/plex_us.m3u",
    "pluto.m3u": "https://github.com/BuddyChewChew/app-m3u-generator/raw/refs/heads/main/playlists/plutotv_us.m3u",
    "samsung.m3u": "https://github.com/BuddyChewChew/app-m3u-generator/raw/refs/heads/main/playlists/samsungtvplus_us.m3u",
    "stirr.m3u": "https://github.com/BuddyChewChew/app-m3u-generator/raw/refs/heads/main/playlists/stirr_all.m3u",
    "tubi.m3u": "https://github.com/BuddyChewChew/app-m3u-generator/raw/refs/heads/main/playlists/tubi_all.m3u"
}
venith_file = "venith.m3u"
venith_url = "https://raw.githubusercontent.com/iptv-org/iptv/master/streams/venith.m3u"

# Download all files
for file_name, url in {**jp_file, **free_tv_files, venith_file: venith_url}.items():
    download_file(url, file_name)

# --- Step 2: Clean JAPAN M3U ---
clean_and_rename_m3u("jp_org.m3u", "JAPAN.m3u", "[JAPAN]")
if os.path.exists("jp1.m3u"):
    clean_and_rename_m3u("jp1.m3u", "jp1.m3u", "[JAPAN]")

# --- Step 3: Clean and Rename Free TV M3U ---
for file_name in free_tv_files.keys():
    clean_and_rename_m3u(file_name, file_name, "[FREE TV]")

# --- Step 4: Clean VENITH ---
if os.path.exists(venith_file):
    clean_venith_m3u(venith_file, "venith_clean.m3u")

# --- Step 5: Merge JAPAN Files ---
output_file_japan = "JAPAN.m3u"
with open(output_file_japan, "a", encoding="utf-8") as outfile:
    if os.path.exists("jp1.m3u"):
        with open("jp1.m3u", "r", encoding="utf-8") as infile:
            outfile.write(infile.read() + "\n")

# --- Step 6: Merge and De-Duplicate Free TV ---
def normalize(text):
    return re.sub(r"\s+", " ", text.strip().lower())

output_file_free_tv = "FREE_TV.m3u"
seen_entries = set()
unique_lines = []

for file_name in free_tv_files.keys():
    if os.path.exists(file_name):
        with open(file_name, "r", encoding="utf-8") as infile:
            lines = infile.readlines()
            i = 0
            while i < len(lines):
                if lines[i].startswith("#EXTINF"):
                    title_match = re.search(r"#EXTINF[^,]*,(.*)", lines[i])
                    if title_match and i + 1 < len(lines):
                        title = normalize(title_match.group(1))
                        url = normalize(lines[i + 1])
                        identifier = f"{title}|{url}"
                        if identifier not in seen_entries:
                            seen_entries.add(identifier)
                            unique_lines.append(lines[i])
                            unique_lines.append(lines[i + 1])
                    i += 2
                else:
                    i += 1

# Write unique entries
with open(output_file_free_tv, "w", encoding="utf-8") as outfile:
    outfile.writelines(unique_lines)

print(f"✅ FREE_TV.m3u de-duplicated and saved.")

# --- Step 7: Merge JAPAN, FREE TV, and VENITH into Final Playlist ---
final_combined_playlist = "SATANSLAYER666_666_hehehe_combined.m3u"
with open(final_combined_playlist, "w", encoding="utf-8") as outfile:
    for fname in [output_file_japan, output_file_free_tv, "venith_clean.m3u"]:
        if os.path.exists(fname):
            with open(fname, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

print(f"✅ Final COMBINED playlist created: {final_combined_playlist}")
