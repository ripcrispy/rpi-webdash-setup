# prior to running this script, please perform the following actions

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

# setup NTP Time
sudo apt-get install ntpdate
sudo ntpdate -u ntp.ubuntu.com

# update raspbian and perform firmware update
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

# install git
sudo apt-get install git-core

# install chromium with mscorefonts for readability
sudo apt-get install chromium ttf-mscorefonts-installer

# -- END

# post script actions

# > autostart chromium, load webpage in kiosk and incognito mode to remove recovery tab on power interrupt
# sudo nano /etc/xdg/lxsession/LXDE-pi/autostart
# ADD:
# /usr/bin/chromium --kiosk --incognito --ignore-certificate-errors --disable-restore-session-state "https://website-goes-here.com"
