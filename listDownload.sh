#!/bin/bash
# Set the variables for bold text, normal text, and how long the terminal should wait to open the Downloads folder
bold=$(tput bold)
normal=$(tput sgr0)
sleepTime=0.05
# The input file that should contain links to all videos, one per line
input="Videos/downloadList.txt"
# Ask the user what format the links should be downloaded in
echo "What format should the links be downloaded in? ${bold}0/Enter ${normal}= Video; ${bold}1 ${normal}= Audio Only"
# Read what the user inputs and assign it to variable $type
read type
# If the user doesn't input any variable, default to video
if [ ! -n "$type" ]; then
# While there's still a new line to read
        while IFS= read -r line
# Download the video
    do
        yt-dlp -P Downloads -o "%(fulltitle)s" --remux-video mp4 --embed-metadata $line
    done < "$input"
# Tell the user the video download is complete, and use read to stop the window from automatically closing.
    echo "${bold}Video Download Complete. ${normal}Press Enter to finish."
    read success
# Open the Downloads folder where the videos are stored
    xdg-open Downloads
# Wait for the sleepTime variable's value to allow the Downloads folder to open
    sleep $sleepTime
# Otherwise if the user inputs 0, repeat above to download video.
elif [ $type == 0 ]; then
    while IFS= read -r line
    do
        yt-dlp -P Downloads -o "%(fulltitle)s" --remux-video mp4 --embed-metadata $line
    done < "$input"
    echo "${bold}Video Download Complete. ${normal}Press Enter to finish."
    
    read success
    xdg-open Downloads
    sleep $sleepTime
# Otherwise if the user inputs 1, download audio instead; code same as above.
elif [ $type == 1 ]; then
    while IFS= read -r line
    do
        yt-dlp -P Downloads -x --audio-format mp3 --embed-metadata $line
    done < "$input"
    echo "${bold}Audio Download Complete. ${normal}Press Enter to finish."
    read success
    xdg-open Downloads
    sleep $sleepTime
# If no input is recognised (i.e. not null, 0 or 1) then tell the user that it isn't recognised, and close the terminal after they press enter.
else
    echo "Sorry, unrecognised input. Please input 0 or 1 next time."
    read failure
fi

