#!/bin/bash
#MattTheTekie's terminal based Youtube searching script. 
#Use -s query, or run the script to query content.
#Requires mpv, and yt-dlp.
while getopts "p:s:" opt; do
  case $opt in
    p)
      playlist=$OPTARG
      mpv "$playlist" --ytdl-format="mp4[height<=?720][fps<=?30]+bestaudio/best"
      ;;
    s)
      searchterm=$OPTARG
          echo $@ >> 1.txt
    sed 's/-s //' -i 1.txt
    sed -n 1,1p 1.txt
    export BWD="$(cat 1.txt)"
    mpv ytdl://ytsearch:"$BWD" --ytdl-format="mp4[height<=?720][fps<=?30]+bestaudio/best"
    rm 1.txt
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done
if [ -z "$searchterm" ] && [ -z "$playlist" ]; then
  echo -n "Enter Searchterm: "
  read searchterm
  mpv ytdl://ytsearch:"$searchterm" --ytdl-format="mp4[height<=?720][fps<=?30]+bestaudio/best"
  fi
