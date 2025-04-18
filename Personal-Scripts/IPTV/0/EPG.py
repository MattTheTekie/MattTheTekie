import os
import xml.etree.ElementTree as ET

# Function to merge multiple EPG files into one
def merge_epg_files(epg_files, output_file):
    # Create the root element for the merged EPG file
    root = ET.Element("tv")

    # Loop through each EPG file and append its channels to the merged root
    for epg_file in epg_files:
        if os.path.exists(epg_file):
            # Parse the current EPG file
            tree = ET.parse(epg_file)
            current_root = tree.getroot()

            # Append each channel from the current file to the root of the merged file
            for channel in current_root.findall("channel"):
                root.append(channel)

            # Append each programme from the current file to the merged file
            for programme in current_root.findall("programme"):
                root.append(programme)

            print(f"Merged {epg_file}")
        else:
            print(f"Warning: {epg_file} not found, skipping...")

    # Create the tree for the merged file and save it to the output file
    merged_tree = ET.ElementTree(root)
    merged_tree.write(output_file, encoding="utf-8", xml_declaration=True)
    print(f"EPG files merged successfully! Saved to: {output_file}")

# List of EPG XML files to merge
epg_files = [
    "roku.xml",        # Example: Replace with the actual path to your EPG files
    "samsung.xml",     # Example: Replace with the actual path to your EPG files
    "plex.xml",        # Example: Replace with the actual path to your EPG files
    "anime.xml",       # Example: Replace with the actual path to your EPG files
    "japan_bk.xml"     # Example: Replace with the actual path to your EPG files
]

# Output file for the merged EPG
output_file = "SATANSLAYER666_666_hehehe_merge.xml"

# Merge the EPG files
merge_epg_files(epg_files, output_file)
