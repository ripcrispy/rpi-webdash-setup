# --- pre-script actions ---

# > extend root file system vol
# sudo raspi-config 

# > edit NIC interfaces
# sudo nano /etc/network/interfaces

# > disable screensaver and stand-by/sleep
# sudo nano /etc/xdg/lxsession/LXDE/autostart
# CHANGE:
# #@xscreensaver -no-splash
# @xset s off
# @xset -dpms
# @xset s noblank

# > cont..
# sudo nano /etc/lightdm/lightdm.conf
# Under [SeatDefaults]
# xserver-command=X -s 0 dpms

# > change keybaord layout
# sudo nano /etc/default/keyboard
# change: XKBLAYOUT="gb" 
# to: XKBLAYOUT="gb"

# > set display mode for dash TV (1360x768p @ 60 Hz with pixel clock 85 MHz)
# sudo nano /boot/config.txt
# CHANGE:
# hdmi_group=2
# hdmi_mode=39

# -- BEGIN SCRIPT
clear
echo rpi-webdash setup script
echo created 2-06-2015
echo **NOTICE**: 
echo Please make sure you have read the contents of 
echo this script before running for pre and post 
echo config instructions.. (sudo nano rpi-webdash-setup.sh)
echo ---
read -p "Are you sure you want to continue? <y/n> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
	# setup NTP Time
	echo Install and setup NTP Server 
	sudo apt-get install ntpdate
	sudo ntpdate -u ntp.ubuntu.com

	# update raspbian and perform firmware update
	echo Update raspbian and perform firmware upgrade
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get dist-upgrade

	# install git
	echo Setup git-core
	sudo apt-get install git-core

	# install chromium with mscorefonts for readability
	echo Install Chromium with mscorefonts
	sudo apt-get install chromium ttf-mscorefonts-installer
else
	echo user cancelled script execution...
	exit 0
fi

# -- END

# --- post-script actions ---

# > autostart chromium, load webpage in kiosk and incognito mode to remove recovery tab on power interrupt
# sudo nano /etc/xdg/lxsession/LXDE-pi/autostart
# ADD:
# /usr/bin/chromium --kiosk --incognito --ignore-certificate-errors --disable-restore-session-state "https://website-goes-here.com"
