#!/bin/bash
#By EZ-Code
white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
NC='\e[0m'
clear
echo ""
echo -e "  ${blue}╔═════════════════════════════════════════════════════════════╗${NC}"
echo -e "${blue}  ║${green} - This feature only for script by EZ-Code                   ${blue}║"
echo -e "${blue}  ║${green} - Please input link to your vps data backup file.           ${blue}║"
echo -e "${blue}  ║${green} - You can check your email if you run backup data by email  ${blue}║"
echo -e "  ${blue}╚═════════════════════════════════════════════════════════════╝${NC}"
echo ""
read -rp "    Link File: " -e url
wget -O backup.zip "$url"
unzip backup.zip
rm -f backup.zip
sleep 1
echo Start Restore
cd /root/backup
cp -r /root/backup/shadow /etc/ &> /dev/null
cp -r /root/backup/gshadow /etc/ &> /dev/null
cp -r /root/backup/passwd /etc/ &> /dev/null
cp -r /root/backup/group /etc/ &> /dev/null
cp -r /root/backup/wireguard /etc/ &> /dev/null
cp -r /root/backup/*.json /usr/local/etc/xray/ >/dev/null
cp -r /root/backup/*.conf /usr/local/etc/xray/ >/dev/null
cp -r /root/backup/public_html/*.conf /home/vps/public_html/ >/dev/null
rm -rf /root/backup
rm -f backup.zip
cd
fixwg
echo Done
echo ""
echo -e "             \033[1;33mRESTORE DATA VPS COMPLETED!\033[0m          "
echo ""
echo ""
echo ""
echo -e "${red}Auto reboot in 3 seconds...${NC}"
echo ""
sleep 3
reboot
