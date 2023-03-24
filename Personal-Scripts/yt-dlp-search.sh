#!/bin/bash
#MattTheTekie's terminal based Youtube searching script. 
#Use -s query, or run the script to query content.
#Requires mpv, and yt-dlp.
#Fix up subs based on
#yt-dlp "https://www.youtube.com/watch?v=PZ1jwzhh6T0" --write-subs --sub-lang "en.*" --sub-format vtt && mv ./*en.vtt s2 && yt-dlp "https://www.youtube.com/watch?v=PZ1jwzhh6T0" -o - | mpv - --shuffle -player-operation-mode=pseudo-gui --screen=1 --sid=1 --sub-file=s2
while getopts "s:" opt; do
  case $opt in
    s)
      searchterm=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [ -z "$searchterm" ]; then
  echo -n "Enter Searchterm: "
  read searchterm
  yt-dlp "ytsearch4:$searchterm" -o - | mpv -
  exit 1
fi

for user in "$@"
do
    echo $@ >> 1.txt
    sed 's/-s //' -i 1.txt
    sed -n 1,1p 1.txt
    export BWD="$(cat 1.txt)"
    yt-dlp "ytsearch4:$BWD" -o - | mpv -
    rm 1.txt
exit
done
