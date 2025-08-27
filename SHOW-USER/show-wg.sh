#!/bin/bash
#By EZ-Code
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
# Port Wg
wg=5820
source /etc/wireguard/params
	NUMBER_OF_CLIENTS=$(grep -c -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
		echo "SHOW USER WIREGUARD"
	echo "Select an existing client that you want to view"
	echo " Press CTRL+C to return"	
	echo -e "==============================="
	echo "     No  User   Expired"
	grep -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf" | cut -d ' ' -f 3-4 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^### Client" "/etc/wireguard/wg0.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
harini=$(grep -E "^### Client" "/etc/wireguard/wg0.conf" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### Client" "/etc/wireguard/wg0.conf" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
	clear
	echo -e ""
	echo -e " INFORMATION ACCOUNT WIREGUARD"
	echo -e "\e[$line═══════════[WIREGUARD]═══════════\e[m"
	echo -e "User      : $user"
	echo -e "Domain    : $domain"
	echo -e "IP/Host   : $MYIP"
    echo -e "Port      : $wg"
	echo -e "\e[$line═════════════════════════════════\e[m"
    echo -e "Wireguard : http://$MYIP:81/$user.conf"
	echo -e "\e[$line═════════════════════════════════\e[m"
	echo -e "Created   : $harini"
	echo -e "Expired   : $exp"
	echo -e ""
	echo -e "Script By $creditt"
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
menu-wg