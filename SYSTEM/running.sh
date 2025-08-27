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
   for((i=0; i<6; i++)); do
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

clear

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

ON="\e[0;32mON\e[0m"
OFF="\e[0;31mOFF\e[0m"

# Status SSH
statusssh="$(systemctl status ssh.service --no-page)"
status_textssh=$(echo "${statusssh}" | grep 'Active:' | cut -f2 -d: | awk '{print $1}')
if [ "${status_textssh}" == "active" ]                           
then
ssh=$ON
else
ssh=$OFF
fi
#!/bin/bash
#By Ez-Code
white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
NC='\e[0m'
#STATUS OVPN
statusovpn="$(systemctl status --now openvpn-server@server-tcp-1194 --no-page)"
status_textovpn=$(echo "${statusovpn}" | grep 'Active:' | cut -f2 -d: | awk '{print $1}')
if [ "${status_textovpn}" == "active" ]
then
ovpn=$ON
else
ovpn=$OFF
fi

#status xray
statusxray="$(systemctl status xray.service --no-page)"
status_textxray=$(echo "${statusxray}" | grep 'Active:' | cut -f2 -d: | awk '{print $1}')
if [ "${status_textxray}" == "active" ]                           
then
xray=$ON
else
xray=$OFF
fi

#status stunnel
statusssl5="$(systemctl status stunnel5.service --no-page)"
status_textssl5=$(echo "${statusssl5}" | grep 'Active:' | cut -f2 -d: | awk '{print $1}')
ONSS="\e[0;32mON\e[0m"
OFFSS="\e[0;31mOFF\e[0m"
if [ "${status_textssl5}" == "active" ]                           
then
ssl5=$ON
else
ssl5=$OFF
fi

#Status dropbear
statusd="$(systemctl status dropbear.service --no-page)"
status_textd=$(echo "${statusd}" | grep 'Active:' | cut -f2 -d: | awk '{print $1}')
if [ "${status_textd}" == "active" ]                           
then
drop=$ON
else
drop=$OFF
fi

#status ssh ws
statushttps="$(systemctl status ws.service --no-page)"
status_texthttps=$(echo "${statushttps}" | grep 'Active:' | cut -f2 -d: | awk '{print $1}')
if [ "${status_texthttps}" == "active" ]                       
then
https=$ON
else
https=$OFF
fi

#status ohp ssh
statusohpssh="$(systemctl status ohps.service --no-page)"
status_textohpssh=$(echo "${statusohpssh}" | grep 'Active:' | cut -f2 -d: | awk '{print $1}')
if [ "${status_textohpssh}" == "active" ]                        
then
ohpssh=$ON
else
ohpssh=$OFF
fi

#status ohp ovpn
statusohpovpn="$(systemctl status ohp.service --no-page)"
status_textohpovpn=$(echo "${statusohpovpn}" | grep 'Active:' | cut -f2 -d: | awk '{print $1}')
if [ "${status_textohpovpn}" == "active" ]                         
then
ohpovpn=$ON
else
ohpovpn=$OFF
fi

#status wg
statuswg="$(systemctl status wg-quick@wg0 --no-page)"
status_textwg=$(echo "${statuswg}" | grep 'Active:' | cut -f2 -d: | awk '{print $1}')
if [ "${status_textwg}" == "active" ]                        
then
wg=$ON
else
wg=$OFF
fi

#status nginx
statusnginx="$(systemctl status nginx.service --no-page)"
status_textnginx=$(echo "${statusnginx}" | grep 'Active:' | cut -f2 -d: | awk '{print $1}')
if [ "${status_textnginx}" == "active" ]
then
nginx=$ON
else
nginx=$OFF
fi

#status squid
statussqd="$(systemctl status squid.service --no-page)"
status_textsqd=$(echo "${statussqd}" | grep 'Active:' | cut -f2 -d: | awk '{print $1}')
if [ "${status_textsqd}" == "active" ]                     
then
sqd=$ON
else
sqd=$OFF
fi

#status udp-custom
statusudp="$(systemctl status udp-custom.service --no-page)"
status_textudp=$(echo "${statusudp}" | grep 'Active:' | cut -f2 -d: | awk '{print $1}')
if [ "${status_textudp}" == "active" ]                     
then
udp=$ON
else
udp=$OFF
fi
echo ""
echo -e ""
echo -e "              \e[0;32m[\e[1;36mSYSTEM STATUS INFORMATION\e[0;32m]\e[0m"
echo -e "             ${green}=============================\e[0m"
echo -e ""
echo -e "    \e[0;33mOPENSSH : $ssh   \e[0;33mOPENVPN : $ovpn   \e[0;33mXRAY-CORE : $xray"
echo ""
echo -e "    \e[0;33mSTUNNEL : $ssl5   \e[0;33mDROPBEAR : $drop   \e[0;33mOHP SSH : $ohpssh"
echo ""
echo -e "    \e[0;33mSSH WS : $https   \e[0;33mWIREGUARD : $wg   \e[0;33mOHP OVPN : $ohpovpn"
echo ""
echo -e "    \e[0;33mSQUID PROXY : $sqd   \e[0;33mNGINX : $nginx   \e[0;33mUDP CUSTOM : $udp"
echo ""
echo ""
echo -e "\e[1;36m---------------------------------------------------------\e[0m"
echo -e "   ${green}NOTED:${NC} ${red}ANY REPORT FOR BUG OR SYSTEM OFF OR SCRIPT ERROR${NC}"
echo -e "     ${red}YOU CAN CONTACT ADMIN ON${NC} \e[0;94mTELEGRAM @EzcodeShop"
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
x-systemd