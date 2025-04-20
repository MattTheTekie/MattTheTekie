import requests
import re
import os
import unicodedata

# Function to download files using requests (only for remote files)
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

# Only download remote files, skip venith.m3u and tv.m3u (as they are local)
for file_name, url in {**jp_file, **free_tv_files}.items():
    download_file(url, file_name)

# --- Step 2: Clean JAPAN M3U ---
clean_and_rename_m3u("jp_org.m3u", "JAPAN.m3u", "[JAPAN]")
if os.path.exists("jp1.m3u"):
    clean_and_rename_m3u("jp1.m3u", "jp1.m3u", "[JAPAN]")

# --- Step 3: Clean and Rename Free TV M3U ---
for file_name in free_tv_files.keys():
    clean_and_rename_m3u(file_name, file_name, "[FREE TV]")

# --- Step 4: Clean VENITH (Local) ---
if os.path.exists("venith.m3u"):
    clean_venith_m3u("venith.m3u", "venith_clean.m3u")

# --- Step 5: Clean and Rename TV M3U (Local) ---
if os.path.exists("tv.m3u"):
    clean_and_rename_m3u("tv.m3u", "tv.m3u", "[TV]")

# --- Step 6: Merge JAPAN Files ---
output_file_japan = "JAPAN.m3u"
with open(output_file_japan, "a", encoding="utf-8") as outfile:
    if os.path.exists("jp1.m3u"):
        with open("jp1.m3u", "r", encoding="utf-8") as infile:
            outfile.write(infile.read() + "\n")

# --- Step 7: Merge Free TV Playlists (No De-Duplication, No Filtering) ---
output_file_free_tv = "FREE_TV.m3u"
with open(output_file_free_tv, "w", encoding="utf-8") as outfile:
    for file_name in free_tv_files.keys():
        if os.path.exists(file_name):
            with open(file_name, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

print(f"✅ FREE_TV.m3u merged (no filtering or deduplication).")

# --- Step 8: Merge JAPAN, FREE TV, VENITH, and TV.M3U into Final Playlist ---
final_combined_playlist = "SATANSLAYER666_666_hehehe_combined.m3u"
with open(final_combined_playlist, "w", encoding="utf-8") as outfile:
    for fname in [output_file_japan, output_file_free_tv, "venith_clean.m3u", "tv.m3u"]:
        if os.path.exists(fname):
            with open(fname, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

print(f"✅ Final COMBINED playlist created: {final_combined_playlist}")
