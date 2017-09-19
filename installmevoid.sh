#!/bin/bash

pause=1

#Installing NetworkManager
xbps-install NetworkManager network-manager-applet gnome-icon-theme gnome-keyring inetutils-ifconfig

#NM services optimization
#Disabling old network
rm -fr /var/service/dhcpcd
rm -fr /var/service/wpa_supplicant
#Enabling NM
ln -s /etc/sv/NetworkManager /var/service
ln -s /etc/sv/dbus /var/service

#Disabling agetty-tty and sshd
rm -fr /var/service/agetty-tty6
rm -fr /var/service/agetty-tty5
rm -fr /var/service/agetty-tty4
rm -fr /var/service/agetty-tty3
rm -fr /var/service/sshd

#Connecting to net with NM
	echo "Pick your wifi device name"
ip addr
	read WIFIDEVICE
	echo""
	echo "Pick your wifi-network name."
	echo ""
iw dev #WIFIDEVICE scan | grep -i ssid
	read WIFINAME
	echo ""
	echo "Type your wifi password"
	read WIFIPASSWORD

nmcli dev wifi connect $WIFINAME password $WIFIPASSWORD

xbps-install -S bbswitch


cp -r ~/void/blacklist/. /etc/modprobe.d/
cp -r ~/void/rc.local /etc/
cp -r ~/void/asound.conf /etc/
mkdir /etc/X11
cp -r ~/void/xorg.conf /etc/X11/
cp -r ~/void/grub /etc/default/
