#!/bin/bash

set -ex

# System packages
sudo apt-get update

sudo apt-get dist-upgrade -y

sudo apt-get -y install cmake nano build-essential git tcl libssl-dev ruby ruby-sinatra ruby-sinatra-contrib usb-modeswitch libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

# Set google DNS as primary DNS servers
sudo mkdir -p /etc/resolvconf/resolv.conf.d/
printf "\nnameserver 8.8.8.8\nnameserver 8.8.4.4\n" | sudo tee -a /etc/resolvconf/resolv.conf.d/head

# Download and setup dhclient and routing
sudo wget https://raw.githubusercontent.com/BELABOX/tutorial/main/dhclient-source-routing -O /etc/dhcp/dhclient-exit-hooks.d/dhclient-source-routing
sudo wget https://raw.githubusercontent.com/BELABOX/tutorial/main/interfaces -O /etc/network/interfaces
printf "100 usb0\n101 usb1\n102 usb2\n103 usb3\n104 usb4\n" | sudo tee -a /etc/iproute2/rt_tables
printf "110 eth0\n111 eth1\n112 eth2\n113 eth3\n114 eth4\n" | sudo tee -a /etc/iproute2/rt_tables

sudo wget https://raw.githubusercontent.com/BELABOX/tutorial/main/nm-source-routing -O /etc/NetworkManager/dispatcher.d/nm-source-routing
sudo chmod 755 /etc/NetworkManager/dispatcher.d/nm-source-routing
printf "120 wlan0\n121 wlan1\n122 wlan2\n123 wlan3\n124 wlan4\n" | sudo tee -a /etc/iproute2/rt_tables

# Disabling nv-l4t-usb-device-mode
if systemctl list-units --type=service | grep -q nv-l4t-usb ;
then
  systemctl stop nv-l4t-usb-device-mode.service
  sudo systemctl disable nv-l4t-usb-device-mode.service
fi

# SRT setup
cd "$HOME" || exit
git clone https://github.com/BELABOX/srt.git
cd srt || exit
./configure --prefix=/usr/local
make -j4
sudo make install
sudo ldconfig

# belacoder setup
cd "$HOME" || exit
git clone https://github.com/BELABOX/belacoder.git
cd belacoder || exit
make

# srtla setup
cd "$HOME" || exit
git clone https://github.com/BELABOX/srtla.git
cd srtla || exit
make

# belaUI setup
cd "$HOME" || exit
git clone https://github.com/rnsc/belaUI.git
cd belaUI || exit

sed -i "s/\/home\/nvidia/$(pwd)/g" setup.json

while true; do
	read -r -p "Do you want to autostart streaming with belaUI? " yn
	case $yn in
		[Yy]* ) sed -i "s/\"autostart\": false/\"autostart\": true/g" setup.json; break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done

while true; do
	read -r -p "Do you want to install belaUI as a service? " yn
	case $yn in
		[Yy]* ) sudo ./install_service.sh; break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done

printf "Please start Firefox on your Jetson to configure belaUI for the first time.\n"
printf "You'll have to provide:\n"
printf "\t* the IP of your SRT receiver/server.\n"
printf "\t* the port of your SRT receiver/server. (most likely 5000 if you haven't changed the default of the moo-the-cow Docker setup)\n"
printf "Go to http://localhost/ in Firefox and happy configuring!\n"

cd "$HOME" || exit
