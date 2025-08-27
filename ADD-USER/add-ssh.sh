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
creditt=$(cat /home/provided)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
clear
echo ""
echo ""
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text             \e[0;30m[\e[$box CREATE USER SSH & OPENVPN\e[0;30m ]\e[0m\e[$back_text             \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "   Username : " -e user
		user_EXISTS=$(grep -w $user /etc/passwd | wc -l)
		
				if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
Login="$user"
read -p "   Password : " Pass
read -p "   Expired (days) : " masaaktif
domain=$(cat /usr/local/etc/xray/domain)
ssl="$(cat ~/log-install.txt | grep -w "STUNNEL" | cut -d: -f2|sed 's/ //g')"
sqd="$(cat ~/log-install.txt | grep -w "SQUID PROXY" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn3="$(cat ~/log-install.txt | grep -w "OHP OPENVPN" | cut -d: -f2|sed 's/ //g')"
ovpn4="$(cat ~/log-install.txt | grep -w "OPENVPN SSL" | cut -d: -f2|sed 's/ //g')"
ohpssh="$(cat ~/log-install.txt | grep -w "OHP SSH" | cut -d: -f2|sed 's/ //g')"
wsdropbear="$(cat ~/log-install.txt | grep -w "SSH WS TLS" | cut -d: -f2|sed 's/ //g')"
wsstunnel="$(cat ~/log-install.txt | grep -w "SSH WS NTLS" | cut -d: -f2|sed 's/ //g')"
udpcustom="$(cat ~/log-install.txt | grep -w "SSH UDP CUSTOM" | cut -d: -f2|sed 's/ //g')"
sleep 1
echo Ping Host
echo Check Acces...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Create Acc: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
harini=`date -d "0 days" +"%Y-%m-%d"`
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
exp1=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "INFORMATION ACCOUNT SSH & OPENVPN"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Username       : $Login"
echo -e "Password       : $Pass"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Domain         : $domain"
echo -e "IP/Host        : $MYIP"
echo -e "OpenSsh        : 22"
echo -e "Dropbear       : 109, 143"
echo -e "Ssl/Tls        : $ssl"
echo -e "Ssh Ws Tls     : $wsdropbear"
echo -e "Ssh Ws Ntls    : $wsstunnel"
echo -e "Ssh Udp Custom : $udpcustom"
echo -e "Ohp OpenSsh    : $ohpssh"
echo -e "Ohp OpenVpn    : $ovpn3"
echo -e "Port Squid     :$sqd"
echo -e "Badvpn(UDPGW)  : 7100-7300"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "SSH SLOW DNS INFORMATION"
echo -e "------------------------"
echo -e "Ssh Slow Dns Port  : 22,80,443,8080"
echo -ne "\033[1;33mName Server(NS):\033[0m " && cat /etc/slowdns/infons
echo -ne "\033[1;33mPublic Key:\033[0m " && cat /root/server.pub
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "CONFIG OPENVPN"
echo -e "--------------"
echo -e "OpenVPN TCP : $ovpn http://$MYIP:81/client-tcp-$ovpn.ovpn"
echo -e "OpenVPN UDP : $ovpn2 http://$MYIP:81/client-udp-$ovpn2.ovpn"
echo -e "OpenVPN SSL : $ovpn4 http://$MYIP:81/client-tcp-ssl.ovpn"
echo -e "OpenVPN OHP : $ovpn3 http://$MYIP:81/client-tcp-ohp1194.ovpn"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "PAYLOAD SSH WS TLS : GET wss://bug.com/ HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]"
echo ""
echo -e "PAYLOAD SSH WS NTLS : GET / HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e ""
echo -e "----------------------"
echo -e "Created  : $harini"
echo -e "Expired  : $exp1"
echo -e "----------------------"
echo -e "Script By $creditt"
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
menu-ssh
