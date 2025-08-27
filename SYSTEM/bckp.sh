#!/bin/bash
#By EZ-Code
IP=$(wget -qO- icanhazip.com);
date=$(date +"%Y-%m-%d")
email=$(cat /home/email)
echo Directory Created
mkdir /root/backup
sleep 1
echo Start Backup
clear
cp -r /etc/shadow /root/backup/shadow >/dev/null 2>&1
cp -r /etc/gshadow /root/backup/gshadow >/dev/null 2>&1
cp -r /etc/passwd /root/backup/passwd >/dev/null 2>&1
cp -r /etc/group /root/backup/group >/dev/null 2>&1
cp -r /etc/wireguard /root/backup/wireguard >/dev/null 2>&1
cp -r /usr/local/etc/xray/*.json /root/backup/ >/dev/null 2>&1
cp -r /usr/local/etc/xray/*.conf /root/backup/ >/dev/null 2>&1
cp -r /home/vps/public_html/*.conf /root/backup/public_html/ >/dev/null 2>&1
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
echo -e "The following is a link to your vps data backup file.

Your VPS IP $IP

$link

If you want to restore data, please enter the link above.

Thank You For Using Our Services
Created by EZ-Code Telegram @EzcodeShop" | mail -s "Backup Data" $email
rm -rf /root/backup
rm -r /root/$IP-$date.zip
echo Done
