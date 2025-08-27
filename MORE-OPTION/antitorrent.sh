#!/bin/bash
#By EZ-Code
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

if [[ $USER != 'root' ]]; then
	echo "Oops! root privileges needed"
	exit
fi
while :
do
	clear
	echo " "
	echo " "
	echo "-----------------------------------------"
	echo "            Install Anti Torrent         "
	echo "-----------------------------------------"
	echo "Anti-torrent was already installed in your server"
	echo "You don't need to touch anything here"
	echo "Just sit back and relax"
	echo " "
	echo " ### By EZ-Code ###"
	echo " "
	echo "     [ MENU ]"
	echo "1. Go Back"
	read -p "Type 1 to go back : " option2
	case $option2 in
		1)
		clear
		exit
		;;
	esac
done
cd
