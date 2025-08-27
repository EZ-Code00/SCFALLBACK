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
xtw="$(cat ~/log-install.txt | grep -w "TROJAN WS TLS" | cut -d: -f2|sed 's/ //g')"
xtw2="$(cat ~/log-install.txt | grep -w "TROJAN WS NTLS" | cut -d: -f2|sed 's/ //g')"
# Create Expried 
masaaktif="1"
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

# Make Random Username 
user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`

patchvtls=/trojan-ws
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
echo -e "\e[$line═══[TRIAL XRAY TROJAN WEBSOCKET]═══\e[m"
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