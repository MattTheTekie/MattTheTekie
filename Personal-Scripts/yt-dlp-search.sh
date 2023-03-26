#!/bin/bash
#MattTheTekie's terminal based Youtube searching script. 
#Use -s query, or run the script to query content.
#Requires mpv, and yt-dlp.
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
  mpv ytdl://ytsearch:"$searchterm" --ytdl-format="bestvideo[height<=?720][fps<=?30]+bestaudio/best" --screen=1 --sid=1
  exit 1
fi

for user in "$@"
do
    echo $@ >> 1.txt
    sed 's/-s //' -i 1.txt
    sed -n 1,1p 1.txt
    export BWD="$(cat 1.txt)"
    mpv ytdl://ytsearch:"$BWD" --ytdl-format="bestvideo[height<=?720][fps<=?30]+bestaudio/best" --screen=1 --sid=1
    rm 1.txt
exit
done
