#!/bin/bash
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

#Colour
white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
NC='\e[0m'

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(grep -c -E "^#duplicate-cn" /etc/openvpn/server/server-tcp-1194.conf)
if [[ "$cek" = "0" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e ""
echo -e "${blue}═════════════════════════════════════════════${NC}"
echo -e ""
echo -e "      ${white}STATUS MULTILOGIN OPENVPN ${NC} $sts "
echo -e ""
echo -e "${blue}  [1]  TURN ON MULTILOGIN OPEN VPN"
echo -e "${blue}  [2]  TURN OFF MULTILOGIN OPEN VPN"
echo -e "${blue}  [x]  EXIT/BACK"
echo -e "${blue}═════════════════════════════════════════════${NC}"
echo -e ""
read -p "     Select From Options [1-2 or x] :  " AutoKill
case $AutoKill in
                1)
                echo -e ""
                sleep 1
                clear
                sed -i "s/#duplicate-cn/duplicate-cn/g" /etc/openvpn/server/server-tcp-1194.conf
				sed -i "s/#duplicate-cn/duplicate-cn/g" /etc/openvpn/server/server-udp-2200.conf
				systemctl restart --now openvpn-server@server-tcp-1194
                systemctl restart --now openvpn-server@server-udp-2200
                echo -e ""
                echo -e "${blue}═══════════════════════════════════════${NC}"
                echo -e ""
                echo -e "      MultiLogin Turn On : ${green}ON ${NC}"
                echo -e ""
                echo -e "${blue}═══════════════════════════════════════${NC}"                                                                                                                                                                                                  
                ;;
                2)
                echo -e ""
                sleep 1
                clear
                sed -i "s/duplicate-cn/#duplicate-cn/g" /etc/openvpn/server/server-tcp-1194.conf
				sed -i "s/duplicate-cn/#duplicate-cn/g" /etc/openvpn/server/server-udp-2200.conf
				systemctl restart --now openvpn-server@server-tcp-1194
                systemctl restart --now openvpn-server@server-udp-2200
                echo -e ""
                echo -e "${blue}═══════════════════════════════════════${NC}"
                echo -e ""
                echo -e "      MultiLogin Turn Off : ${red}OFF ${NC}"
                echo -e ""
                echo -e "${blue}═══════════════════════════════════════${NC}"                                                                                                                                
                ;;
                x)
                clear
                menu-ssh
				exit
                ;;
        esac
		
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
duplicate
