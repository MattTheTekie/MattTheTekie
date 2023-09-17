echo  > myfile.txt && rm myfile.txt && echo "You're watching; VENOM's DOC C0RN3R on DRAGON TV" > myfile.txt & timeout 40m ./yt-dlp_linux https://www.youtube.com/@johnnyharris/ --format="[fps<=30]" -o - --write-subs --sub-lang "en.*" --sub-format vtt | mpv - --shuffle -player-operation-mode=pseudo-gui --screen=1 --sid=1--sub-file=s2

