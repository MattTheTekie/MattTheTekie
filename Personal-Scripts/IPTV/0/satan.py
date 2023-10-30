# Open the M3U file and read its content
with open('/home/runner/work/MattTheTekie/MattTheTekie/Personal-Scripts/IPTV/0/jp_org.m3u', 'r') as file:
    lines = file.readlines()

# Remove duplicates
lines_seen = set()
new_lines = []
for line in lines:
    if line not in lines_seen:
        new_lines.append(line)
        lines_seen.add(line)

# Write the non-duplicate content back to the file
with open('/home/runner/work/MattTheTekie/MattTheTekie/Personal-Scripts/IPTV/0/jp_org.m3u', 'w') as file:
    file.writelines(new_lines)
