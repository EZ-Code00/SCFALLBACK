#!/bin/bash
# By EZ-Code
# ==================================================
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


fun_bar_on_off () {
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
   for((i=0; i<5; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.5s
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

# Valid Script
VALIDITY () {
#TARIKH EXP
today=`date -d "0 days" +"%Y-%m-%d"`
exp=$(cat /usr/bin/e)	
    if [[ $today < $exp ]]; then
    echo -e ""
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m"
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}

#CHECK IZIN IPVPS
clear
echo -e "[\e[32;1mINFO\e[0m] LOADING . . ."
fun_start () {
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
IZIN=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
echo "$IZIN" > /usr/bin/ipvps
}
fun_bar 'fun_start'
IZIN2=$(cat /usr/bin/ipvps)
if [ $MYIP = $IZIN2 ]; then
VALIDITY
else
clear
echo ""
echo ""
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi

white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
GitUser="Y16ZR"

#TURN ON
clear
fun_on_vless () {
rm -f /etc/nginx/conf.d/xray.conf
#nginx config
cat >/etc/nginx/conf.d/xray.conf <<EOF
    server {
             listen 80;
             listen [::]:80;
             listen 443 ssl http2 reuseport;
             listen [::]:443 http2 reuseport;	
             server_name 127.0.0.1 localhost;
             ssl_certificate /usr/local/etc/xray/xray.crt;
             ssl_certificate_key /usr/local/etc/xray/xray.key;
             ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
             ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
             root /home/vps/public_html;
        }
EOF

#VLESS WS MULTIPATH
sed -i '$ ilocation /' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iif ($http_upgrade != "Upgrade") {' /etc/nginx/conf.d/xray.conf
sed -i '$ irewrite /(.*) /vless-ws break;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14011;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#VMESS WS
sed -i '$ ilocation = /vmess-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14012;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#TROJAN WS
sed -i '$ ilocation = /trojan-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14015;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#VLESS GRPC
sed -i '$ ilocation ^~ /vless-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14013;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#VMESS GRPC
sed -i '$ ilocation ^~ /vmess-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14014;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#TROJAN GRPC
sed -i '$ ilocation ^~ /trojan-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14016;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

systemctl restart nginx

rm -f /etc/stunnel5/stunnel5.conf
cat > /etc/stunnel5/stunnel5.conf <<-END
cert = /usr/local/etc/xray/xray.crt
key = /usr/local/etc/xray/xray.key
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[ssh]
accept = 777
connect = 127.0.0.1:22

[dropbear]
accept = 222
connect = 127.0.0.1:109

[sshwstls]
accept = 8443
connect = 700

[openvpn]
accept = 110
connect = 127.0.0.1:1194

END
systemctl restart stunnel5

rm -f /root/log-install.txt
cd
#wget -O /root/log-install.txt "https://raw.githubusercontent.com/Y16ZR/SCFALLBACK/main/log-installws.txt"

echo "====================[PREMIUM SCRIPT]===================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "   >>> SERVICE & PORT" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "    [INFORMATION SSH & OPENVPN]" | tee -a log-install.txt
echo "    ---------------------------" | tee -a log-install.txt
echo "   - OPENSSH                 : 22" | tee -a log-install.txt
echo "   - OPENVPN                 : TCP 1194, UDP 2200" | tee -a log-install.txt
echo "   - OPENVPN SSL             : 110" | tee -a log-install.txt
echo "   - SSH SLOW DNS            : ANY PORT USED" | tee -a log-install.txt
echo "   - STUNNEL                 : 222, 777" | tee -a log-install.txt
echo "   - DROPBEAR                : 109, 143" | tee -a log-install.txt
echo "   - OHP SSH                 : 8686" | tee -a log-install.txt
echo "   - OHP OPENVPN             : 8787" | tee -a log-install.txt
echo "   - SSH WS TLS              : 8443" | tee -a log-install.txt
echo "   - SSH WS NTLS             : 8880" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "    [INFORMATION SQUID,BADVPN,NGINX]" | tee -a log-install.txt
echo "    --------------------------------" | tee -a log-install.txt
echo "   - SQUID PROXY             : 3128, 8080 (limit to IP Server)" | tee -a log-install.txt
echo "   - BADVPN                  : 7100, 7200, 7300" | tee -a log-install.txt
echo "   - NGINX                   : 81" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "    [INFORMATION WIREGUARD]" | tee -a log-install.txt
echo "    -----------------------" | tee -a log-install.txt
echo "   - WIREGUARD               : 5820" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "    [INFORMATION XRAY]" | tee -a log-install.txt
echo "    ------------------" | tee -a log-install.txt
echo "   - VMESS/VLESS WS TLS      : 443" | tee -a log-install.txt
echo "   - VMESS/VLESS GRPC TLS    : 443" | tee -a log-install.txt
echo "   - TROJAN WS TLS           : 443" | tee -a log-install.txt
echo "   - TROJAN GRPC TLS         : 443" | tee -a log-install.txt
echo "   - VMESS/VLESS WS NTLS     : 80" | tee -a log-install.txt
echo "   - TROJAN WS NTLS          : 80" | tee -a log-install.txt
echo "   ----------------------------------------------------" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "   >>> SERVER INFORMATION & OTHER FEATURE" | tee -a log-install.txt
echo "   - TIMEZONE                : ASIA/KUALA_LUMPUR (GMT +8)" | tee -a log-install.txt
echo "   - IPTABLES                : [ON]" | tee -a log-install.txt
echo "   - IPV6                    : [OFF]" | tee -a log-install.txt
echo "   - AUTO DELETE EXPIRED ACCOUNT VPN" | tee -a log-install.txt
echo "   - INSTALLATION LOG --> /root/log-install.txt" | tee -a log-install.txt
echo "-------------------- SCRIPT EZ-CODE -------------------" | tee -a log-install.txt
echo "" | tee -a log-install.txt
}

fun_on_vmess () {
rm -f /etc/nginx/conf.d/xray.conf
#nginx config
cat >/etc/nginx/conf.d/xray.conf <<EOF
    server {
             listen 80;
             listen [::]:80;
             listen 443 ssl http2 reuseport;
             listen [::]:443 http2 reuseport;	
             server_name 127.0.0.1 localhost;
             ssl_certificate /usr/local/etc/xray/xray.crt;
             ssl_certificate_key /usr/local/etc/xray/xray.key;
             ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
             ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
             root /home/vps/public_html;
        }
EOF

#VMESS WS MULTIPATH
sed -i '$ ilocation /' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iif ($http_upgrade != "Upgrade") {' /etc/nginx/conf.d/xray.conf
sed -i '$ irewrite /(.*) /vmess-ws break;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14012;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#VLESS WS
sed -i '$ ilocation = /vless-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14011;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#TROJAN WS
sed -i '$ ilocation = /trojan-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14015;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#VLESS GRPC
sed -i '$ ilocation ^~ /vless-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14013;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#VMESS GRPC
sed -i '$ ilocation ^~ /vmess-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14014;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#TROJAN GRPC
sed -i '$ ilocation ^~ /trojan-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14016;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

systemctl restart nginx

rm -f /etc/stunnel5/stunnel5.conf
cat > /etc/stunnel5/stunnel5.conf <<-END
cert = /usr/local/etc/xray/xray.crt
key = /usr/local/etc/xray/xray.key
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[ssh]
accept = 777
connect = 127.0.0.1:22

[dropbear]
accept = 222
connect = 127.0.0.1:109

[sshwstls]
accept = 8443
connect = 700

[openvpn]
accept = 110
connect = 127.0.0.1:1194

END
systemctl restart stunnel5

rm -f /root/log-install.txt
cd
#wget -O /root/log-install.txt "https://raw.githubusercontent.com/Y16ZR/SCFALLBACK/main/log-installws.txt"
echo "====================[PREMIUM SCRIPT]===================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "   >>> SERVICE & PORT" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "    [INFORMATION SSH & OPENVPN]" | tee -a log-install.txt
echo "    ---------------------------" | tee -a log-install.txt
echo "   - OPENSSH                 : 22" | tee -a log-install.txt
echo "   - OPENVPN                 : TCP 1194, UDP 2200" | tee -a log-install.txt
echo "   - OPENVPN SSL             : 110" | tee -a log-install.txt
echo "   - SSH SLOW DNS            : ANY PORT USED" | tee -a log-install.txt
echo "   - STUNNEL                 : 222, 777" | tee -a log-install.txt
echo "   - DROPBEAR                : 109, 143" | tee -a log-install.txt
echo "   - OHP SSH                 : 8686" | tee -a log-install.txt
echo "   - OHP OPENVPN             : 8787" | tee -a log-install.txt
echo "   - SSH WS TLS              : 8443" | tee -a log-install.txt
echo "   - SSH WS NTLS             : 8880" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "    [INFORMATION SQUID,BADVPN,NGINX]" | tee -a log-install.txt
echo "    --------------------------------" | tee -a log-install.txt
echo "   - SQUID PROXY             : 3128, 8080 (limit to IP Server)" | tee -a log-install.txt
echo "   - BADVPN                  : 7100, 7200, 7300" | tee -a log-install.txt
echo "   - NGINX                   : 81" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "    [INFORMATION WIREGUARD]" | tee -a log-install.txt
echo "    -----------------------" | tee -a log-install.txt
echo "   - WIREGUARD               : 5820" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "    [INFORMATION XRAY]" | tee -a log-install.txt
echo "    ------------------" | tee -a log-install.txt
echo "   - VMESS/VLESS WS TLS      : 443" | tee -a log-install.txt
echo "   - VMESS/VLESS GRPC TLS    : 443" | tee -a log-install.txt
echo "   - TROJAN WS TLS           : 443" | tee -a log-install.txt
echo "   - TROJAN GRPC TLS         : 443" | tee -a log-install.txt
echo "   - VMESS/VLESS WS NTLS     : 80" | tee -a log-install.txt
echo "   - TROJAN WS NTLS          : 80" | tee -a log-install.txt
echo "   ----------------------------------------------------" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "   >>> SERVER INFORMATION & OTHER FEATURE" | tee -a log-install.txt
echo "   - TIMEZONE                : ASIA/KUALA_LUMPUR (GMT +8)" | tee -a log-install.txt
echo "   - IPTABLES                : [ON]" | tee -a log-install.txt
echo "   - IPV6                    : [OFF]" | tee -a log-install.txt
echo "   - AUTO DELETE EXPIRED ACCOUNT VPN" | tee -a log-install.txt
echo "   - INSTALLATION LOG --> /root/log-install.txt" | tee -a log-install.txt
echo "-------------------- SCRIPT EZ-CODE -------------------" | tee -a log-install.txt
echo "" | tee -a log-install.txt
}

fun_off () {
rm -f /etc/nginx/conf.d/xray.conf
#nginx config
cat >/etc/nginx/conf.d/xray.conf <<EOF
    server {
             listen 80;
             listen [::]:80;
             listen 443 ssl http2 reuseport;
             listen [::]:443 http2 reuseport;	
             server_name *.$domain;
             ssl_certificate /usr/local/etc/xray/xray.crt;
             ssl_certificate_key /usr/local/etc/xray/xray.key;
             ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
             ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
             root /home/vps/public_html;
        }
EOF

#VLESS WS
sed -i '$ ilocation = /vless-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14011;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#VMESS WS
sed -i '$ ilocation = /vmess-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14012;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#TROJAN WS
sed -i '$ ilocation = /trojan-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14015;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#SSH WS
sed -i '$ ilocation /' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:700;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#VLESS GRPC
sed -i '$ ilocation ^~ /vless-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14013;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#VMESS GRPC
sed -i '$ ilocation ^~ /vmess-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14014;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#TROJAN GRPC
sed -i '$ ilocation ^~ /trojan-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14016;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

systemctl restart nginx

rm -f /etc/stunnel5/stunnel5.conf
cat > /etc/stunnel5/stunnel5.conf <<-END
cert = /usr/local/etc/xray/xray.crt
key = /usr/local/etc/xray/xray.key
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[ssh]
accept = 777
connect = 127.0.0.1:22

[dropbear]
accept = 222
connect = 127.0.0.1:109

[openvpn]
accept = 110
connect = 127.0.0.1:1194

END
systemctl restart stunnel5

rm -f /root/log-install.txt
cd
#wget -O /root/log-install.txt "https://raw.githubusercontent.com/Y16ZR/SCFALLBACK/main/log-install.txt"
echo "====================[PREMIUM SCRIPT]===================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "   >>> SERVICE & PORT" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "    [INFORMATION SSH & OPENVPN]" | tee -a log-install.txt
echo "    ---------------------------" | tee -a log-install.txt
echo "   - OPENSSH                 : 22" | tee -a log-install.txt
echo "   - OPENVPN                 : TCP 1194, UDP 2200" | tee -a log-install.txt
echo "   - OPENVPN SSL             : 110" | tee -a log-install.txt
echo "   - SSH SLOW DNS            : ANY PORT USED" | tee -a log-install.txt
echo "   - STUNNEL                 : 222, 777" | tee -a log-install.txt
echo "   - DROPBEAR                : 109, 143" | tee -a log-install.txt
echo "   - OHP SSH                 : 8686" | tee -a log-install.txt
echo "   - OHP OPENVPN             : 8787" | tee -a log-install.txt
echo "   - SSH WS TLS              : 443" | tee -a log-install.txt
echo "   - SSH WS NTLS             : 80" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "    [INFORMATION SQUID,BADVPN,NGINX]" | tee -a log-install.txt
echo "    --------------------------------" | tee -a log-install.txt
echo "   - SQUID PROXY             : 3128, 8080 (limit to IP Server)" | tee -a log-install.txt
echo "   - BADVPN                  : 7100, 7200, 7300" | tee -a log-install.txt
echo "   - NGINX                   : 81" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "    [INFORMATION WIREGUARD]" | tee -a log-install.txt
echo "    -----------------------" | tee -a log-install.txt
echo "   - WIREGUARD               : 5820" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "    [INFORMATION XRAY]" | tee -a log-install.txt
echo "    ------------------" | tee -a log-install.txt
echo "   - VMESS/VLESS WS TLS      : 443" | tee -a log-install.txt
echo "   - VMESS/VLESS GRPC TLS    : 443" | tee -a log-install.txt
echo "   - TROJAN WS TLS           : 443" | tee -a log-install.txt
echo "   - TROJAN GRPC TLS         : 443" | tee -a log-install.txt
echo "   - VMESS/VLESS WS NTLS     : 80" | tee -a log-install.txt
echo "   - TROJAN WS NTLS          : 80" | tee -a log-install.txt
echo "   ----------------------------------------------------" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "   >>> SERVER INFORMATION & OTHER FEATURE" | tee -a log-install.txt
echo "   - TIMEZONE                : ASIA/KUALA_LUMPUR (GMT +8)" | tee -a log-install.txt
echo "   - IPTABLES                : [ON]" | tee -a log-install.txt
echo "   - IPV6                    : [OFF]" | tee -a log-install.txt
echo "   - AUTO DELETE EXPIRED ACCOUNT VPN" | tee -a log-install.txt
echo "   - INSTALLATION LOG --> /root/log-install.txt" | tee -a log-install.txt
echo "-------------------- SCRIPT EZ-CODE -------------------" | tee -a log-install.txt
echo "" | tee -a log-install.txt
}


ONVLESS="\e[0;32mMULTIPATH VLESS ON\e[0m"
ONVMESS="\e[0;32mMULTIPATH VMESS ON\e[0m"
OFF="\e[0;31mMULTIPATH OFF\e[0m"
statusvless="$(cat /etc/nginx/conf.d/xray.conf | grep -i /vless-ws | awk '{print $4}' | tail -n1)"
statusvmess="$(cat /etc/nginx/conf.d/xray.conf | grep -i /vmess-ws | awk '{print $4}' | tail -n1)"
if [ "${statusvless}" == "break;" ]
then
sts=$ONVLESS
elif [ "${statusvmess}" == "break;" ]
then
sts=$ONVMESS
else
sts=$OFF
fi

pilihan () {
clear
echo ""
echo -e "   .--------------------------------------."
echo -e "   | ${blue}TURN ON/OFF MULTIPATH VMESS/VLESS WS\e[0m |"
echo -e "   '--------------------------------------'"
echo -e "   ${red} NOTE\e[0m: ${white}If your turn on multipath,"
echo -e "          SSH WS port change to 8443/8880."
echo -e "   ${yellow} STATUS: ${sts}"
echo -e ""
echo -e "     ${blue} 1)\e[0m TURN ON FOR VLESS WS\e[0m"
echo -e "     ${blue} 2)\e[0m TURN ON FOR VMESS WS\e[0m"
echo -e "     ${blue} 3)\e[0m TURN OFF MULTIPATH\e[0m"
echo -e "     ${blue} 4)\e[0m BACK TO MAIN MENU\e[0m"
echo -e "    -------------------------------------"
read -p "     Please select numbers 1-4 : " SC
echo ""
if [[ $SC == "1" ]]; then
fun_bar_on_off 'fun_on_vless'
echo -e "${green}MULTIPATH VLESS TURN ON DONE.. ${NC}"
sleep 3
path
elif [[ $SC == "2" ]]; then
fun_bar_on_off 'fun_on_vmess'
echo -e "${green}MULTIPATH VMESS TURN ON DONE.. ${NC}"
sleep 3
path
elif [[ $SC == "3" ]]; then
fun_bar_on_off 'fun_off'
echo -e "${green}MULTIPATH TURN OFF DONE.. ${NC}"
sleep 3
path
elif [[ $SC == "4" ]]; then
menu
else
clear
echo False Options
pilihan
fi
}
domain=$(cat /usr/local/etc/xray/domain)
pilihan
