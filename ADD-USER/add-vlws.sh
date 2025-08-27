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



#Colour
white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
NC='\e[0m'
# PROVIDED
creditt=$(cat /home/provided)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
MYIP=$(curl -sS ipv4.icanhazip.com)
domain=$(cat /usr/local/etc/xray/domain)
clear
echo ""
echo ""
tls="$(cat ~/log-install.txt | grep -w "VMESS/VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "VMESS/VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')"

echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text             \e[0;30m[\e[$box CREATE USER XRAY VLESS WS \e[0;30m ]\e[0m\e[$back_text            \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "   Username: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
patchvless=/vless-ws
uuid=$(cat /proc/sys/kernel/random/uuid)
choose_bug () {
echo -e "   .-----------------------------------."
echo -e "   |       ${blue}Choose Your Trick VPN       \e[0m|"
echo -e "   '-----------------------------------'"
echo -e "     ${blue}1)\e[0m Bug as sni"
echo -e "     ${blue}2)\e[0m Bug as address, host & patch"
echo -e "     ${blue}3)\e[0m Bug as address"
echo -e "     ${blue}4)\e[0m Default config"
echo -e "   ------------------------------------"
read -p "   Please select numbers 1-4: " trick
if [[ $trick == "1" ]]; then
tri=DEFAULT
elif [[ $trick == "2" ]]; then
tri=DEFAULT2
elif [[ $trick == "3" ]]; then
tri=DEFAULT3
elif [[ $trick == "4" ]]; then
tri=DEFAULT4
elif [[ $trick == "" ]]; then
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
choose_bug
else
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
choose_bug
fi
}
choose_bug
if [[ $tri == "DEFAULT" ]]; then
echo ""
read -p "   Bug As Address (Example: www.google.com) : " address
read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni
read -p "   Expired (days) : " masaaktif
bug_addr=${address}.
bug_addr2=$address
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
elif [[ $tri == "DEFAULT2" ]]; then
echo ""
read -p "   Bug As Address (Example: www.google.com) : " address
read -p "   Bug As Host (Example : m.facebook.com) : " sni
read -p "   Bug As Patch (Note : For none tls only) : " bugpath
read -p "   Expired (days) : " masaaktif
bug_addr=${address}
bug_addr2=bug.com
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
bug_path=${bugpath}.
bug_path2=$bugpath
if [[ $bugpath == "" ]]; then
stp=$bug_path2
else
stp=$bug_path
fi
elif [[ $tri == "DEFAULT3" ]]; then
echo ""
read -p "   Bug As Address (Example: www.google.com) : " address
read -p "   Expired (days) : " masaaktif
bug_addr=${address}
bug_addr2=bug.com
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
elif [[ $tri == "DEFAULT4" ]]; then
echo ""
read -p "   Expired (days) : " masaaktif
else
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
choose_bug
fi
#BUG SNI
bug_sni=bug.com
bug_sni2=${sni}
if [[ $sni == "" ]]; then
stn=${bug_sni}
else
stn=$bug_sni2
fi
#CONFIG
if [[ $tri == "DEFAULT" ]]; then
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`

sed -i '/#vless-ws$/a\#vlsws '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vless-ws$/a\#vlsws '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlessws.json
vlesslink1="vless://${uuid}@${sts}${domain}:$tls?path=${patchvless}&security=tls&encryption=none&host=${domain}&type=ws&sni=${stn}#${user}"
vlesslink2="vless://${uuid}@${sts}${domain}:$none?path=${patchvless}&security=none&encryption=none&host=${stn}&type=ws#${user}"
systemctl restart xray
systemctl restart xray@vlessws
clear
echo -e "\e[$line═════[ACC XRAY VLESS WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port Tls       : ${tls}"
echo -e "Port None Tls  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Path           : ${patchvless}"
echo -e "Network        : Websocket"
echo -e "AllowInsecure  : True"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Link Vless Tls : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Link Vless None TLS  : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"

elif [[ $tri == "DEFAULT2" ]]; then
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`

sed -i '/#vless-ws$/a\#vlsws '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vless-ws$/a\#vlsws '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlessws.json
vlesslink1="vless://${uuid}@${sts}:$tls?path=wss%3A%2F%2F${domain}${patchvless}&security=tls&encryption=none&host=${stn}&type=ws&sni=${domain}#${user}"
vlesslink2="vless://${uuid}@${sts}:$none?path=wss%3A%2F%2F${stp}${domain}${patchvless}&security=none&encryption=none&host=${stn}&type=ws#${user}"
systemctl restart xray
systemctl restart xray@vlessws
clear
echo -e "\e[$line═════[ACC XRAY VLESS WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port Tls       : ${tls}"
echo -e "Port None Tls  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Path           : ${patchvless}"
echo -e "Network        : Websocket"
echo -e "AllowInsecure  : True"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Link Vless Tls : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Link Vless None TLS  : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"

elif [[ $tri == "DEFAULT3" ]]; then
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`

sed -i '/#vless-ws$/a\#vlsws '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vless-ws$/a\#vlsws '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlessws.json
vlesslink1="vless://${uuid}@${sts}:$tls?path=${patchvless}&security=tls&encryption=none&host=${domain}&type=ws&sni=${domain}#${user}"
vlesslink2="vless://${uuid}@${sts}:$none?path=${patchvless}&security=none&encryption=none&host=${domain}&type=ws#${user}"
systemctl restart xray
systemctl restart xray@vlessws
clear
echo -e "\e[$line═════[ACC XRAY VLESS WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port Tls       : ${tls}"
echo -e "Port None Tls  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Path           : ${patchvless}"
echo -e "Network        : Websocket"
echo -e "AllowInsecure  : True"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Link Vless Tls : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Link Vless None TLS  : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"

elif [[ $tri == "DEFAULT4" ]]; then
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`

sed -i '/#vless-ws$/a\#vlsws '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vless-ws$/a\#vlsws '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlessws.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=${patchvless}&security=tls&encryption=none&host=${domain}&type=ws&sni=${domain}#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=${patchvless}&security=none&encryption=none&host=${domain}&type=ws#${user}"
systemctl restart xray
systemctl restart xray@vlessws
clear
echo -e "\e[$line═════[ACC XRAY VLESS WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port Tls       : ${tls}"
echo -e "Port None Tls  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Path           : ${patchvless}"
echo -e "Network        : Websocket"
echo -e "AllowInsecure  : True"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Link Vless Tls : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Link Vless None TLS  : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"
else
echo -e "${red}ERROR ${NC}"
sleep 1
fi
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
x-vlws