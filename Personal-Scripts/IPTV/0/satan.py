FILE_PATH = "combined.m3u"
keptLines = []
seenChannels = set()

with open(FILE_PATH, "r", encoding="utf-8") as file:
    while True:
        line = file.readline()
        if not line:
            break

        if not line.startswith("#EXTINF") or "group-title=\"Japanese TV\", " not in line:
            keptLines.append(line)
            continue

        channelName = line.split("group-title=\"Japanese TV\", ")[1].strip()

        if not channelName:
            print("Unable to find channel name for line:", line)
            exit()

        url = file.readline()
        if not url:
            print("Unable to find URL after line:", line)
            exit()

        # If the channel has been seen, drop both the channel line and the URL
        if channelName in seenChannels:
            continue

        # Update seen channels
        seenChannels.add(channelName)

        keptLines.append(line)
        keptLines.append(url)

# Write output
with open(FILE_PATH, "w", encoding="utf-8") as file:
    file.writelines(keptLines)

print("Processed file:", FILE_PATH)
