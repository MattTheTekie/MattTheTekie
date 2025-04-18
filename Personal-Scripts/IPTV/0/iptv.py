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

# Step 1: Download JP and Free TV IPTV Files
jp_file = {"jp_org.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/master/streams/jp.m3u"}
free_tv_files = {
    "ca.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/refs/heads/gh-pages/countries/ca.m3u",
    "uk.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/refs/heads/gh-pages/countries/uk.m3u",
    "us.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/refs/heads/gh-pages/countries/us.m3u",
    "au.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/refs/heads/gh-pages/countries/au.m3u",
    "nz.m3u": "https://raw.githubusercontent.com/iptv-org/iptv/refs/heads/gh-pages/countries/nz.m3u"
}

# Download files
for file_name, url in {**jp_file, **free_tv_files}.items():
    download_file(url, file_name)

# Step 2: Remove brackets/parentheses and rename channels
def clean_and_rename_m3u(input_file, output_file, prefix):
    with open(input_file, "r", encoding="utf-8") as f:
        content = f.read()

    # Remove anything in brackets [] or parentheses ()
    content = re.sub(r"[\[\(].*?[\]\)]", "", content)

    # Rename channels by prefixing
    content = re.sub(r'(#EXTINF[^,]*,)(.*)', rf'\1 {prefix} \2', content)

    with open(output_file, "w", encoding="utf-8") as f:
        f.write(content)

# Apply to JP
clean_and_rename_m3u("jp_org.m3u", "JAPAN.m3u", "[JAPAN]")

# Apply to Free TV files
for file_name in free_tv_files.keys():
    clean_and_rename_m3u(file_name, file_name, "[FREE TV]")

# Step 3: Merge JP Channels
output_file_japan = "JAPAN.m3u"  # Already created by clean_and_rename_m3u

# Step 4: Merge Free TV Channels
output_file_free_tv = "FREE_TV.m3u"
with open(output_file_free_tv, "w", encoding="utf-8") as outfile:
    for file_name in free_tv_files.keys():
        if os.path.exists(file_name):
            with open(file_name, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

# Step 5: Download and Extract EPG Files
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

# Step 6: Extract GZ Files
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

# Step 7: Merge EPG Files
merged_epg_file = "merged_epg.xml"
with open(merged_epg_file, "w", encoding="utf-8") as outfile:
    for file_name in epg_files.keys():
        extracted_file = file_name.replace(".gz", "")
        if os.path.exists(extracted_file):
            with open(extracted_file, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

print(f"\n✅ JP IPTV saved as: {output_file_japan}")
print(f"✅ Free TV merged as: {output_file_free_tv}")
print(f"✅ Merged EPG saved as: {merged_epg_file}")
