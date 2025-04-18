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

# Function to clean and rename M3U
def clean_and_rename_m3u(input_file, output_file, prefix):
    with open(input_file, "r", encoding="utf-8") as f:
        content = f.read()

    # Remove anything in brackets [] or parentheses ()
    content = re.sub(r"[\[\(].*?[\]\)]", "", content)

    # Standardize group-title
    group_title = "Japanese TV" if prefix == "[JAPAN]" else prefix.strip("[]")
    content = re.sub(r'group-title=".*?"', f'group-title="{group_title}"', content)
    content = re.sub(r'(#EXTINF:-1\s*)(?!.*group-title)', rf'\1group-title="{group_title}" ', content)

    # Prefix the channel name
    content = re.sub(r'(#EXTINF[^,]*,)(.*)', rf'\1 {prefix} \2', content)

    with open(output_file, "w", encoding="utf-8") as f:
        f.write(content)

# Step 1: Download JP and Free TV IPTV Files
jp_file = {"jp_org.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/master/streams/jp.m3u"}
free_tv_files = {
    "ca.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/refs/heads/gh-pages/countries/ca.m3u",
    "uk.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/refs/heads/gh-pages/countries/uk.m3u",
    "us.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/refs/heads/gh-pages/countries/us.m3u",
    "au.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/refs/heads/gh-pages/countries/au.m3u",
    "nz.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/refs/heads/gh-pages/countries/nz.m3u"
}

for file_name, url in {**jp_file, **free_tv_files}.items():
    download_file(url, file_name)

# Step 2: Clean and rename JAPAN files
clean_and_rename_m3u("jp_org.m3u", "JAPAN.m3u", "[JAPAN]")

if os.path.exists("jp1.m3u"):
    clean_and_rename_m3u("jp1.m3u", "jp1.m3u", "[JAPAN]")

# Step 3: Clean and rename FREE TV files
for file_name in free_tv_files.keys():
    clean_and_rename_m3u(file_name, file_name, "[FREE TV]")

# Step 4: Merge JAPAN + jp1
output_file_japan = "JAPAN.m3u"
with open(output_file_japan, "a", encoding="utf-8") as outfile:
    if os.path.exists("jp1.m3u"):
        with open("jp1.m3u", "r", encoding="utf-8") as infile:
            outfile.write(infile.read() + "\n")

# Step 5: Merge FREE TV files
output_file_free_tv = "FREE_TV.m3u"
with open(output_file_free_tv, "w", encoding="utf-8") as outfile:
    for file_name in free_tv_files.keys():
        if os.path.exists(file_name):
            with open(file_name, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

# Step 6: Download and Extract EPG Files
epg_files = {
    "plex.xml": "https://i.mjh.nz/Plex/us.xml",
    "samsung.xml": "https://i.mjh.nz/SamsungTVPlus/all.xml",
    "pluto.xml": "https://i.mjh.nz/PlutoTV/us.xml",
    "anime.xml.gz": "https://epgshare01.online/epgshare01/epg_ripper_ID1.xml.gz",
    "japan_bk.xml.gz": "https://epgshare01.online/epgshare01/epg_ripper_JP1.xml.gz",
    "iptvjapan.xml": "https://www.bevy.be/bevyfiles/japan.xml"
}

for file_name, url in epg_files.items():
    download_file(url, file_name)

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

merged_epg_file = "SATANSLAYER666_666_hehehe_merge.xml"
with open(merged_epg_file, "w", encoding="utf-8") as outfile:
    for file_name in epg_files.keys():
        extracted_file = file_name.replace(".gz", "")
        if os.path.exists(extracted_file):
            with open(extracted_file, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

print(f"\n✅ JP IPTV saved as: {output_file_japan}")
print(f"✅ Free TV merged as: {output_file_free_tv}")
print(f"✅ Merged EPG saved as: {merged_epg_file}")

# Step 7: Merge JAPAN, FREE TV, and VENITH (unmodified) into one file
final_combined_playlist = "SATANSLAYER666_666_hehehe_combined.m3u"
with open(final_combined_playlist, "w", encoding="utf-8") as outfile:
    for fname in [output_file_japan, output_file_free_tv, "venith.m3u"]:
        if os.path.exists(fname):
            with open(fname, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

print(f"🔥 Final COMBINED playlist created: {final_combined_playlist}")
