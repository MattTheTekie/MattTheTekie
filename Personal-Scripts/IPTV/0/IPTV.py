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
    content = re.sub(r"[\[\(].*?[\]\)]", "", content)
    content = re.sub(r'(#EXTINF[^,]*,)(.*)', rf'\1 {prefix} \2', content)
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(content)

# Apply to JP
clean_and_rename_m3u("jp_org.m3u", "JAPAN.m3u", "[JAPAN]")

# Also process jp1.m3u and jp2.m3u as Japanese channels
for jp_extra in ["jp1.m3u", "jp2.m3u"]:
    if os.path.exists(jp_extra):
        clean_and_rename_m3u(jp_extra, jp_extra, "[JAPAN]")

# Apply to Free TV files
for file_name in free_tv_files.keys():
    clean_and_rename_m3u(file_name, file_name, "[FREE TV]")

# Step 3: Merge JP Channels
output_file_japan = "JAPAN.m3u"
with open(output_file_japan, "a", encoding="utf-8") as outfile:
    for jp_extra in ["jp1.m3u", "jp2.m3u"]:
        if os.path.exists(jp_extra):
            with open(jp_extra, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

# Step 4: Merge Free TV Channels
output_file_free_tv = "FREE_TV.m3u"
with open(output_file_free_tv, "w", encoding="utf-8") as outfile:
    for file_name in free_tv_files.keys():
        if os.path.exists(file_name):
            with open(file_name, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

# Step 5: Process VENITH.m3u
venith_file = "VENITH.m3u"
if os.path.exists("venith.m3u"):
    clean_and_rename_m3u("venith.m3u", venith_file, "[VENITH]")
    print("✅ VENITH.m3u created with prefix [VENITH]")
else:
    print("❌ venith.m3u not found!")

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

# Step 7: Extract GZ Files
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

# Step 8: Merge EPG Files
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

# Step 9: Merge JAPAN and FREE_TV into one file
final_merged_playlist = "SATANSLAYER666_666_hehehe_combined.m3u"
with open(final_merged_playlist, "w", encoding="utf-8") as outfile:
    for fname in [output_file_japan, output_file_free_tv]:
        if os.path.exists(fname):
            with open(fname, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

print(f"✅ All channels merged into: {final_merged_playlist}")

# Step 10: Merge VENITH into the full playlist
final_full_playlist = "SATANSLAYER666_666_hehehe_full.m3u"
with open(final_full_playlist, "w", encoding="utf-8") as outfile:
    for fname in [final_merged_playlist, venith_file]:
        if os.path.exists(fname):
            with open(fname, "r", encoding="utf-8") as infile:
                outfile.write(infile.read() + "\n")

print(f"🔥 Final FULL playlist created: {final_full_playlist}")
