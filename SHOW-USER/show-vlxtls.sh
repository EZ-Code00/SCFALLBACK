#!/bin/bash
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
clear
xtls="$(cat ~/log-install.txt | grep -w "VLESS TCP XTLS" | cut -d: -f2|sed 's/ //g')"
NUMBER_OF_CLIENTS=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY VLESS XTLS"
	echo "Select the existing client you want to view"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	echo "     No  User   Expired"
	grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
harini=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
vlesslink1="vless://${uuid}@${domain}:$xtls?security=tls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-vision&sni=${domain}#${user}"
clear
echo -e ""
echo -e "\e[$line════════[XRAY VLESS XTLS]════════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Ip/Host        : ${MYIP}"
echo -e "Port Xtls      : $xtls"
echo -e "User ID        : ${uuid}"
echo -e "Encryption     : None"
echo -e "Network        : TCP"
echo -e "Flow           : Vision Tls"
echo -e "AllowInsecure  : True"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Xtls  : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created  : $harini"
echo -e "Expired  : $exp"
echo -e "Script By $creditt"
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
x-vlws