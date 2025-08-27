#!/bin/bash
# PROVIDED
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
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
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/usr/local/etc/xray/akuntrws.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY TROJAN WS"
	echo "Select the existing client you want to view"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	echo "     No  User   Expired"
	grep -E "^### " "/usr/local/etc/xray/akuntrws.conf" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
patchvtls=/trojan-ws
xtw="$(cat ~/log-install.txt | grep -w "TROJAN WS TLS" | cut -d: -f2|sed 's/ //g')"
xtw2="$(cat ~/log-install.txt | grep -w "TROJAN WS NTLS" | cut -d: -f2|sed 's/ //g')"

user=$(grep -E "^### " "/usr/local/etc/xray/akuntrws.conf" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
harini=$(grep -E "^### " "/usr/local/etc/xray/akuntrws.conf" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/usr/local/etc/xray/akuntrws.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^### " "/usr/local/etc/xray/akuntrws.conf" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
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

echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
x-trws