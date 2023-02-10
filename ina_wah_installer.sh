#!/bin/bash

#This is for Manjaro Linux.
#Adapt to other distros is necessary.
#Author: GothicDread
#Version: 1.0

#Fetch necessary packages
#Most of the required binaries were already present in my OS when I tried to create this
#sudo pacman -S --needed cvlc curl
#Probably anything PulseAudio related. Try googling

#create and write the script file
touch ~/ina_wah.sh;
echo '#!/bin/bash

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
' > ~/ina_wah.sh;

#give it executable permitions
chmod +x ~/ina_wah.sh;

#Fetch some env vars required
USER=$(whoami)
MY_ID=$(id --user)

#Create the service file and write the necessary junk into it
touch /etc/systemd/system/ina_wah.service;
echo '[Unit]
Description=Ina Wah Service

[Service]
Type=simple
Environment=DISPLAY=:0 PULSE_SERVER=unix:/run/user/$MY_ID/pulse/native
ExecStart=/bin/bash /home/$USER/ina_script.sh
Restart=always
User=$USER

[Install]
WantedBy=multi-user.target
' > /etc/systemd/system/ina_wah.service;

#Reload the daemon to apply service changes,
#add service to be launched on system boot
#and start the service
systemctl daemon-reload;
systemctl enable ina_wah.service;
systemctl start ina_wah.service;
