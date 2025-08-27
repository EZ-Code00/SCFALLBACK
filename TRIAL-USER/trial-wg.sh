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

# Load params
source /etc/wireguard/params
domain=$(cat /usr/local/etc/xray/domain)
clear
echo ""
# Create Expried 
masaaktif="1"

# Make Random Username 
CLIENT_NAME=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`

#CONFIG
harini=`date -d "0 days" +"%Y-%m-%d"`

	ENDPOINT="${sts}$domain:$SERVER_PORT"
	WG_CONFIG="/etc/wireguard/wg0.conf"
	LASTIP=$( grep "/32" $WG_CONFIG | tail -n1 | awk '{print $3}' | cut -d "/" -f 1 | cut -d "." -f 4 )
	if [[ "$LASTIP" = "" ]]; then
	CLIENT_ADDRESS="10.66.66.2"
	else
	CLIENT_ADDRESS="10.66.66.$((LASTIP+1))"
	fi
	
	# Port Wg
	wg=5820

	# Adguard DNS by default
	CLIENT_DNS_1="8.8.8.8"

	CLIENT_DNS_2="8.8.4.4"
	MYIP=$(wget -qO- ifconfig.co);
	exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
        harini=`date -d "0 days" +"%Y-%m-%d"`

	# Generate key pair for the client
	CLIENT_PRIV_KEY=$(wg genkey)
	CLIENT_PUB_KEY=$(echo "$CLIENT_PRIV_KEY" | wg pubkey)
	CLIENT_PRE_SHARED_KEY=$(wg genpsk)

	# Create client file and add the server as a peer
	echo "[Interface]
PrivateKey = $CLIENT_PRIV_KEY
Address = $CLIENT_ADDRESS/24
DNS = $CLIENT_DNS_1,$CLIENT_DNS_2

[Peer]
PublicKey = $SERVER_PUB_KEY
PresharedKey = $CLIENT_PRE_SHARED_KEY
Endpoint = $ENDPOINT
AllowedIPs = 0.0.0.0/0,::/0" >>"$HOME/$SERVER_WG_NIC-client-$CLIENT_NAME.conf"

	# Add the client as a peer to the server
	echo -e "### Client $CLIENT_NAME $exp $harini
[Peer]
PublicKey = $CLIENT_PUB_KEY
PresharedKey = $CLIENT_PRE_SHARED_KEY
AllowedIPs = $CLIENT_ADDRESS/32" >>"/etc/wireguard/$SERVER_WG_NIC.conf"
	systemctl restart "wg-quick@$SERVER_WG_NIC"
	cp $HOME/$SERVER_WG_NIC-client-$CLIENT_NAME.conf /home/vps/public_html/$CLIENT_NAME.conf
	clear
	sleep 0.5
	echo Generate PrivateKey
	sleep 0.5
	echo Generate PublicKey
	sleep 0.5
	echo Generate PresharedKey
	clear
	echo -e ""
	echo -e " INFORMATION ACCOUNT WIREGUARD"
	echo -e "\e[$line═══════════[WIREGUARD]═══════════\e[m"
	echo -e "User      : $CLIENT_NAME"
	echo -e "Domain    : $domain"
	echo -e "IP/Host   : $MYIP"
    echo -e "Port      : $wg"
	echo -e "\e[$line═════════════════════════════════\e[m"
    echo -e "Wireguard : http://$MYIP:81/$CLIENT_NAME.conf"
	echo -e "\e[$line═════════════════════════════════\e[m"
	echo -e "Created   : $harini"
	echo -e "Expired   : $exp"
	echo -e "Script By $creditt"
	rm -f /root/wg0-client-$CLIENT_NAME.conf
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
menu-wg