#!/bin/bash

#Zeros for string format, to fetch correct sound files
ZEROS=000000;

#Fetch a random number between 1 and 480
RANDOM=$(date +%s | cut -b10-19);
RAND_NUMBER=$[$RANDOM % 480 + 1];

#Format the string correctly
temp_num="$ZEROS$RAND_NUMBER";
INA_WAH=WAH_${temp_num:(-4)};

#Fetch the mp3 from the website and play it locally
curl -o /tmp/INA_WAH.mp3 https://inanoises.com/resources/noises/$INA_WAH.mp3;
cvlc --no-xlib --play-and-exit /tmp/INA_WAH.mp3;
rm -f /tmp/INA_WAH.mp3;

# Add a random delay between 1 and 5 minutes
sleep $((RANDOM % 300 + 60));

