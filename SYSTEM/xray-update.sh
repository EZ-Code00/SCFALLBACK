#!/bin/bash
#wget https://github.com/${GitUser}/
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
   sleep 0.2s
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


fun_bar_update () {
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
   for((i=0; i<5; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.5s
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

#Colour
white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
NC='\e[0m'

clear
fun_start_update () {
#UNZIP XRAY LINUX 64
cd `mktemp -d`
curl -sL "$xraycore_link" -o xray.zip
unzip -q xray.zip && rm -rf xray.zip
mv xray /usr/local/bin/xray
chmod +x /usr/local/bin/xray
systemctl restart xray
systemctl restart xray@none
}

update () {
echo -e "   .--------------------------------------------------."
echo -e "        ${blue}Do you want to update ${green}Xray-Core v${latest_version}??"
echo -e "   '--------------------------------------------------'"
echo -e "     ${blue}1)\e[0m Yes (Continue)"
echo -e "     ${blue}2)\e[0m No (Back to main menu)"
echo -e "    ------------------------------------"
read -p "     Please select numbers 1-2 : " SC
echo ""
if [[ $SC == "1" ]]; then
fun_bar_update 'fun_start_update'
systemctl restart xray
echo -e "${green} UPDATE DONE.. BACK TO MAIN MENU${NC}"
sleep 3
menu
elif [[ $SC == "2" ]]; then
clear
menu
fi
}

#VERSION XRAY INSTALLED ON SCRIPT
xray_version="$(xray version | head -n 1 | awk '{print $2}')"

#CHECK VERSION XRAY CORE LATEST VERSION
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"

#INSTALLATION XRAY CORE LATEST VERSION
xraycore_link="https://github.com/XTLS/Xray-core/releases/download/v$latest_version/xray-linux-64.zip"

echo ""
echo ""
echo -e "${blue} Checking xray version & latest version for update... ${NC}"
sleep 3
echo ""
if [ $xray_version = $latest_version ]; then
echo ""
echo ""
echo -e "${green} Your xray core is latest version Thank You. ${NC}"
sleep 1
echo -e "${green} Back to main menu..wait.. ${NC}"
sleep 2
menu
else
clear
echo ""
echo ""
echo -e "${green} New latest version of xray core available"
sleep 2
clear
update
fi