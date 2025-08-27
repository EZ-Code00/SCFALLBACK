#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/usr/local/etc/xray/akuntrws.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	echo ""
	echo " DELETE XRAY TROJAN WS"
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo "     No  User   Expired"
	grep -E "^### " "/usr/local/etc/xray/akuntrws.conf" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
harini=$(grep -E "^### " "/usr/local/etc/xray/akuntrws.conf" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^### " "/usr/local/etc/xray/akuntrws.conf" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
CLIENT_NAME=$(grep -E "^### " "/usr/local/etc/xray/akuntrws.conf" | cut -d ' ' -f 2-3 | sed -n "${CLIENT_NUMBER}"p)
user=$(grep -E "^### " "/usr/local/etc/xray/akuntrws.conf" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/usr/local/etc/xray/akuntrws.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^### $user $exp $harini $uuid/d" /usr/local/etc/xray/akuntrws.conf
sed -i "/^#trw $user $exp $harini $uuid/,/^},{/d" /usr/local/etc/xray/config.json
systemctl restart xray
service cron restart
clear
clear
echo " XRAY TROJAN WS Account Deleted Successfully"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp"
echo " =========================="
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
x-trws