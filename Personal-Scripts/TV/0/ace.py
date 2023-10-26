FILE_PATH = "/home/runner/work/MattTheTekie/MattTheTekie/Personal-Scripts/TV/1/combined.m3u"

keptLines = []
seenChannels = set()

with open(FILE_PATH, "r") as file:
    while True:
        line = file.readline()
        if not line: break
        
        if not line.startswith("#EXTINF") or "group-title=\"Free TV\", " not in line:
            keptLines.append(line)
            continue
        
        channelName = line.split("group-title=\"Free TV\", ")[1]
        
        if not channelName:
            print("Unable to find channel name for line", line)
            exit()
            
        url = file.readline()
        if not url:
            print("Unable to find url after line", line)
        
        # If the channel has been seen, drop both the channel line and the url
        if channelName in seenChannels:
            continue
        
        # Update seen channels
        seenChannels.add(channelName)
        
        keptLines.append(line)
        keptLines.append(url)
    
# Write output
with open(FILE_PATH, "w") as file:
    file.writelines(keptLines)

print("Processed file:", FILE_PATH)
