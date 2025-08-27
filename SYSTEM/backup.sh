#!/bin/bash
#By EZ-Code
GitUser="EZ-Code00"

fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<1; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}

#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)

# Valid Script
VALIDITY () {
#TARIKH EXP
today=`date -d "0 days" +"%Y-%m-%d"`
exp=$(cat /usr/bin/e)	
    if [[ $today < $exp ]]; then
    echo -e ""
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m"
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}

#CHECK IZIN IPVPS
clear
echo -e "[\e[32;1mINFO\e[0m] LOADING . . ."
fun_start () {
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
IZIN=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
echo "$IZIN" > /usr/bin/ipvps
}
fun_bar 'fun_start'
IZIN2=$(cat /usr/bin/ipvps)
if [ $MYIP = $IZIN2 ]; then
VALIDITY
else
clear
echo ""
echo ""
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi
#COLOUR
white='\e[0;37m'
blue='\e[0;34m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
green='\e[0;32m'
NC='\e[0m'

IP=$(curl -sS ipv4.icanhazip.com);
date=$(date +"%Y-%m-%d")
clear
echo ""
echo -e "  ${blue}════════════════════════════════════════════════════════════${NC}"
echo -e "  ${blue}                      VPS BACKUP DATA                       ${NC}"
echo -e "  ${blue}════════════════════════════════════════════════════════════${NC}"
echo -e "   ${green}Enter Your Email To Receive Message/Link Restore${NC}"
read -rp "   Email: " -e email
sleep 1
echo -e "${green} DIRECTORY CREATED${NC}"
cd
mkdir /root/backup
sleep 1
echo ""
echo -e "${green} START BACKUP DATA"
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

Your IP VPS $IP

$link

If you want to restore data, please copy and enter the link above.

Thank You For Using Our Services
Created by EZ-Code Telegram https://t.me/EzcodeShop" | mail -s "Backup Data" $email
rm -rf /root/backup
rm -r /root/$IP-$date.zip
echo -e "${green}DONE"
echo "Please Check Your Email"
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
menu-br


