import requests
import re
import os
import gzip

# Function to download files using requests
def download_file(url, filename):
    response = requests.get(url, stream=True)
    if response.status_code == 200:
        with open(filename, "wb") as file:
            file.write(response.content)
        print(f"Downloaded: {filename}")
    else:
        print(f"Failed to download: {url}")

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

# Step 1: Download JP, Free TV, and VENITH IPTV Files
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

# Download all IPTV M3U files
for file_name, url in {**jp_file, **free_tv_files, venith_file: venith_url}.items():
    download_file(url, file_name)

# Step 2: Clean JAPAN M3U files
clean_and_rename_m3u("jp_org.m3u", "JAPAN.m3u", "[JAPAN]")

# Clean jp1.m3u if it exists
if os.path.exists("jp1.m3u"):
    clean_and_rename_m3u("jp1.m3u", "jp1.m3u", "[JAPAN]")

# Step 3: Clean and Rename Free TV files
for file_name in free_tv_files.keys():
    clean_and_rename_m3u(file_name, file_name, "[FREE TV]")

# Step 4: Clean VENITH M3U (no modifications, just remove brackets/parentheses)
if os.path.exists(venith_file):
    clean_venith_m3u(venith_file, "venith_clean.m3u")

# Step 5: Merge JAPAN files
output_file_japan = "JAPAN.m3u"
with open(output_file_japan, "a", encoding="utf-8") as outfile:
    if os.path.exists("jp1.m3u"):
        with open("jp1.m3u", "r", encoding="utf-8") as infile:
            outfile.write(infile.read() + "\n")

# Step 6: Merge and de-duplicate Free TV files
output_file_free_tv = "FREE_TV.m3u"
seen_titles = set()
unique_lines = []

for file_name in free_tv_files.keys():
    if os.path.exists(file_name):
        with open(file_name, "r", encoding="utf-8") as infile:
            lines = infile.readlines()
            i = 0
            while i < len(lines):
                if lines[i].startswith("#EXTINF"):
                    title_match = re.search(r"#EXTINF[^,]*,(.*)", lines[i])
                    if title_match:
                        title = title_match.group(1).strip()
                        url = lines[i+1].strip() if i+1 < len(lines) else ""
                        identifier = f"{title}|{url}"
                        if identifier not in seen_titles:
                            seen_titles.add(identifier)
                            unique_lines.append(lines[i])
                            if i+1 < len(lines):
                                unique_lines.append(lines[i+1])
                    i += 2
                else:
                    i += 1

with open(output_file_free_tv, "w", encoding="utf-8") as outfile:
    outfile.writelines(unique_lines)

print(f"✅ FREE_TV.m3u de-duplicated and saved.")

# Step 7: Download and Extract EPG Files
epg_files = {
    "roku.xml": "https://i.mjh.nz/Roku/all.xml",
    "samsung.xml": "https://i.mjh.nz/SamsungTVPlus/all.xml",
    "plex.xml": "https://i.mjh.nz/Plex/all.xml",
    "anime.xml.gz": "https://epgshare01.online/epgshare01/epg_ripper_ID1.xml.gz",
    "japan_bk.xml.gz": "https://epgshare01.online/epgshare01/epg_ripper_JP1.xml.gz"
}

# Download EPG files
for file_name, url in epg_files.items():
    download_file(url, file_name)

# Extract compressed EPG files
compressed_files = ["anime.xml.gz", "japan_bk.xml.gz"]
for file in compressed_files:
    if os.path.exists(file):
        decompressed_file = file.replace(".gz", "")
        with gzip.open(file, "rb") as f_in:
            with open(decompressed_file, "wb") as f_out:
                f_out.write(f_in.read())
        print(f"Extracted: {decompressed_file}")
    else:
        print(f"Compressed file not found: {file}")

# Step 8: Merge EPG Files into a single XML
merged_epg_file = "SATANSLAYER666_666_hehehe_merge.xml"
with open(merged_epg_file, "w", encoding="utf-8") as outfile:
    for file_name in epg_files.keys():
        extracted_file = file_name.replace(".gz", "")
        if os.path.exists(extracted_file):
            with open(extracted_file, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

print(f"✅ Merged EPG saved as: {merged_epg_file}")

# Step 9: Merge JAPAN, FREE TV, and VENITH into one combined playlist
final_combined_playlist = "SATANSLAYER666_666_hehehe_combined.m3u"
with open(final_combined_playlist, "w", encoding="utf-8") as outfile:
    for fname in [output_file_japan, output_file_free_tv, "venith_clean.m3u"]:
        if os.path.exists(fname):
            with open(fname, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

print(f"✅ Final COMBINED playlist created: {final_combined_playlist}")
