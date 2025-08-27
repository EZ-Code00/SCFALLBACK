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



red='\e[1;31m'
green='\e[0;32m'
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

uuid=$(cat /proc/sys/kernel/random/uuid)
clear
xtw="$(cat ~/log-install.txt | grep -w "TROJAN WS TLS" | cut -d: -f2|sed 's/ //g')"

xtw2="$(cat ~/log-install.txt | grep -w "TROJAN WS NTLS" | cut -d: -f2|sed 's/ //g')"
clear
echo ""
echo ""
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text         \e[0;30m[\e[$box CREATE USER XRAY TROJAN WEBSOCKET\e[0;30m ]\e[0m\e[$back_text         \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "   Password: " -e user
		user_EXISTS=$(grep -w $user /usr/local/etc/xray/akuntrws.conf | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
patchvtls=/trojan-ws
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

if [[ $tri == "DEFAULT" ]]; then
harini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojan-ws$/a\#trw '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","password": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
echo -e "### $user $exp $harini $uuid" >> /usr/local/etc/xray/akuntrws.conf
trojanlink="trojan://${user}@${sts}${domain}:${xtw}?path=${patchvtls}&security=tls&host=${stn}&type=ws&sni=${stn}#${user}"
trojanlink2="trojan://${user}@${sts}${domain}:${xtw2}?security=none&type=ws&headerType=none&path=${patchvtls}&host=${stn}#${user}"
systemctl restart xray
clear
echo -e ""
echo -e "\e[$line═══════[XRAY TROJAN WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : ${MYIP}"
echo -e "Port Tls       : ${xtw}"
echo -e "Port None Tls  : ${xtw2}"
echo -e "Key            : ${user}"
echo -e "Network        : Websocket"
echo -e "AllowInsecure  : True"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Trojan Tls : ${trojanlink}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Trojan None Tls : ${trojanlink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created  : $harini"
echo -e "Expired  : $exp"
echo -e "Script By $creditt"

elif [[ $tri == "DEFAULT2" ]]; then
harini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojan-ws$/a\#trw '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","password": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
echo -e "### $user $exp $harini $uuid" >> /usr/local/etc/xray/akuntrws.conf
trojanlink="trojan://${user}@${sts}:${xtw}?path=wss%3A%2F%2F${domain}${patchvtls}&security=tls&host=${stn}&type=ws&sni=${domain}#${user}"
trojanlink2="trojan://${user}@${sts}:${xtw2}?security=none&type=ws&headerType=none&path=wss%3A%2F%2F${stp}${domain}&host=${stn}#${user}"
systemctl restart xray
clear
echo -e ""
echo -e "\e[$line═══════[XRAY TROJAN WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : ${MYIP}"
echo -e "Port Tls       : ${xtw}"
echo -e "Port None Tls  : ${xtw2}"
echo -e "Key            : ${user}"
echo -e "Network        : Websocket"
echo -e "AllowInsecure  : True"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Trojan Tls : ${trojanlink}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Trojan None Tls : ${trojanlink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created  : $harini"
echo -e "Expired  : $exp"
echo -e "Script By $creditt"

elif [[ $tri == "DEFAULT3" ]]; then
harini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojan-ws$/a\#trw '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","password": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
echo -e "### $user $exp $harini $uuid" >> /usr/local/etc/xray/akuntrws.conf
trojanlink="trojan://${user}@${sts}:${xtw}?path=${patchvtls}&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
trojanlink2="trojan://${user}@${sts}:${xtw2}?security=none&type=ws&headerType=none&path=${patchvtls}&host=${domain}#${user}"
systemctl restart xray
clear
echo -e ""
echo -e "\e[$line═══════[XRAY TROJAN WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : ${MYIP}"
echo -e "Port Tls       : ${xtw}"
echo -e "Port None Tls  : ${xtw2}"
echo -e "Key            : ${user}"
echo -e "Network        : Websocket"
echo -e "AllowInsecure  : True"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Trojan Tls : ${trojanlink}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Trojan None Tls : ${trojanlink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created  : $harini"
echo -e "Expired  : $exp"
echo -e "Script By $creditt"

elif [[ $tri == "DEFAULT4" ]]; then
harini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojan-ws$/a\#trw '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","password": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
echo -e "### $user $exp $harini $uuid" >> /usr/local/etc/xray/akuntrws.conf
trojanlink="trojan://${user}@${domain}:${xtw}?path=${patchvtls}&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
trojanlink2="trojan://${user}@${domain}:${xtw2}?security=none&type=ws&headerType=none&path=${patchvtls}&host=${domain}#${user}"
systemctl restart xray
clear
echo -e ""
echo -e "\e[$line═══════[XRAY TROJAN WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : ${MYIP}"
echo -e "Port Tls       : ${xtw}"
echo -e "Port None Tls  : ${xtw2}"
echo -e "Key            : ${user}"
echo -e "Network        : Websocket"
echo -e "AllowInsecure  : True"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Trojan Tls : ${trojanlink}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Trojan None Tls : ${trojanlink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created  : $harini"
echo -e "Expired  : $exp"
echo -e "Script By $creditt"
else
echo -e "${red}ERROR ${NC}"
sleep 1
fi
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
x-trws