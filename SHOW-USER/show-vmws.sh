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
tls="$(cat ~/log-install.txt | grep -w "VMESS/VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "VMESS/VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')"
NUMBER_OF_CLIENTS=$(grep -c -E "^#vmsws " "/usr/local/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY VMESS & VLESS WS"
	echo "Select the existing client you want to view"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	echo "     No  User   Expired"
	grep -E "^#vmsws " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
pathvmess=/vmess-ws
user=$(grep -E "^#vmsws " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
harini=$(grep -E "^#vmsws " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#vmsws " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^#vmsws " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$pathvmess",
      "type": "none",
      "host": "$domain",
      "tls": "tls",
	    "sni": "$domain"
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$pathvmess",
      "type": "none",
      "host": "$domain",
      "tls": "none"
}
EOF

vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"

clear
echo -e "\e[$line═════[ACC XRAY VMESS WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port Tls       : ${tls}"
echo -e "Port None Tls  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Path           : ${pathvmess}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "AllowInsecure  : True"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Link Vmess Tls : ${vmesslink1}"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Link Vmess None TLS  : ${vmesslink2}"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
x-vmws