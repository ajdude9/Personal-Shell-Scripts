#!/bin/bash
xsel -ob 2> /dev/null > "Shell Scripts"/clipboardHolder.txt
line=$(head -n 1 "Shell Scripts"/clipboardHolder.txt)
yt-dlp -P Downloads -o "%(fulltitle)s" --remux-video mp4 --embed-metadata $line
notify-send --hint=int:transient:1 --app-name= "Clipboard Downloader" "Download complete."
