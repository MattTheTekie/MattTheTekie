import os
import requests
import gzip
import shutil
import xml.etree.ElementTree as ET

# EPG URLs and corresponding local filenames
epg_sources = {
    "roku.xml": "https://i.mjh.nz/Roku/all.xml",
    "samsung.xml": "https://i.mjh.nz/SamsungTVPlus/all.xml",
    "plex.xml": "https://i.mjh.nz/Plex/all.xml",
    "anime.xml.gz": "https://epgshare01.online/epgshare01/epg_ripper_ID1.xml.gz",
    "japan_bk.xml.gz": "https://epgshare01.online/epgshare01/epg_ripper_JP1.xml.gz",
    "moveonjoy.xml": "https://raw.githubusercontent.com/ydbf/MoveOnJoy/refs/heads/main/epg.xml",
    "epgtalk.xml.gz": "https://github.com/acidjesuz/EPGTalk/raw/refs/heads/master/guide.xml.gz",
    "epg_ripper_all_sources1.xml.gz": "https://epgshare01.online/epgshare01/epg_ripper_ALL_SOURCES1.xml.gz",
    "epg_ripper_us_locals2.xml.gz": "https://epgshare01.online/epgshare01/epg_ripper_US_LOCALS2.xml.gz",
    "epg_ripper_us1.xml.gz": "https://epgshare01.online/epgshare01/epg_ripper_US1.xml.gz",
    "epg_ripper_dummy_channels.xml.gz": "https://epgshare01.online/epgshare01/epg_ripper_DUMMY_CHANNELS.xml.gz"
}

# Download and decompress EPG files
for filename, url in epg_sources.items():
    print(f"Downloading: {url}")
    response = requests.get(url, stream=True)
    if response.status_code == 200:
        with open(filename, "wb") as f:
            f.write(response.content)
        print(f"Saved: {filename}")

        # If it's a .gz file, decompress it
        if filename.endswith(".gz"):
            decompressed_filename = filename[:-3]  # remove .gz extension
            with gzip.open(filename, 'rb') as f_in:
                with open(decompressed_filename, 'wb') as f_out:
                    shutil.copyfileobj(f_in, f_out)
            print(f"Decompressed: {decompressed_filename}")
    else:
        print(f"Failed to download {url} (status code {response.status_code})")

# Function to merge multiple EPG files into one
def merge_epg_files(epg_files, output_file):
    root = ET.Element("tv")

    for epg_file in epg_files:
        if os.path.exists(epg_file):
            try:
                tree = ET.parse(epg_file)
                current_root = tree.getroot()

                for channel in current_root.findall("channel"):
                    root.append(channel)

                for programme in current_root.findall("programme"):
                    root.append(programme)

                print(f"Merged {epg_file}")
            except Exception as e:
                print(f"Error parsing {epg_file}: {e}")
        else:
            print(f"Warning: {epg_file} not found, skipping...")

    merged_tree = ET.ElementTree(root)
    merged_tree.write(output_file, encoding="utf-8", xml_declaration=True)
    print(f"EPG files merged successfully! Saved to: {output_file}")

# List of decompressed or XML files to merge
epg_files = [
    "roku.xml",
    "samsung.xml",
    "plex.xml",
    "anime.xml",     # decompressed from anime.xml.gz
    "japan_bk.xml",  # decompressed from japan_bk.xml.gz
    "moveonjoy.xml", 
    "epgtalk.xml",   # decompressed from epgtalk.xml.gz
    "epg_ripper_all_sources1.xml",  # decompressed from epg_ripper_all_sources1.xml.gz
    "epg_ripper_us_locals2.xml",   # decompressed from epg_ripper_us_locals2.xml.gz
    "epg_ripper_us1.xml",         # decompressed from epg_ripper_us1.xml.gz
    "epg_ripper_dummy_channels.xml" # decompressed from epg_ripper_dummy_channels.xml.gz
]

# Output file for merged result
output_file = "SATANSLAYER666_666_hehehe_merge.xml"

# Merge EPG files
merge_epg_files(epg_files, output_file)
