#Streams device to the Raspberry Pi based FM transmitter via VLC, and FFMPEG. - Made by MattTheTekie.
export HOST_IP="Insert-Host-IP-here"
export FREQ="Enter-FM-frequency-here"
vlc -vvv pulse://$(pactl list | grep "Monitor Source" | awk '{print $3}') --sout '#transcode{acodec=flac,ab=128,channels=2}:standard{access=http,dst=0.0.0.0:8888/pc.mp3}'
echo "Please run the following on the Raspberry Pi. ffmpeg -i http://$HOST_IP:8888/pc.mp3  -f wav pipe:1 | sudo ./fm_transmitter -f $FREQ"
