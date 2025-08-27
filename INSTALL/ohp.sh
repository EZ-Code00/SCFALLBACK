#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="EZ-Code00"
#Open HTTP Puncher By EZ-Code
#Direct Proxy Squid For OpenVPN TCP
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'
MYIP=$(curl -sS ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
domain=$(cat /usr/local/etc/xray/domain)
#Update Repository VPS
#Port Server ovpn ohp
#Jika Ingiin Mengubah Port Silahkan Sesuaikan Dengan Port Yang Ada Di VPS Mu
Port_OpenVPN_TCP='1194';
Port_Squid='3128';
Port_OHP='8787';
clear
#Installing ohp Server
cd 
wget -q -O /usr/local/bin/ohp "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/ohp"
chmod +x /usr/local/bin/ohp

#Buat File OpenVPN TCP OHP
cat > /etc/openvpn/client-tcp-ohp1194.ovpn <<END
############## WELCOME ###############
############ By EZ-Code ##############
client
dev tun
proto tcp
remote "bug.com" 1194
resolv-retry infinite
route-method exe
nobind
remote-cert-tls server
cipher AES-256-CBC
auth SHA256
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3

setenv FRIENDLY_NAME "TCP OHP VPN"
http-proxy $domain 8787
http-proxy-option CUSTOM-HEADER CONNECT HTTP/1.1
http-proxy-option CUSTOM-HEADER Host bug.com
http-proxy-option CUSTOM-HEADER X-Online-Host bug.com
http-proxy-option CUSTOM-HEADER X-Forward-Host bug.com
http-proxy-option CUSTOM-HEADER Connection: keep-alive
END

sed -i $MYIP2 /etc/openvpn/client-tcp-ohp1194.ovpn;

# masukkan certificatenya ke dalam config client TCP 1194
echo '<ca>' >> /etc/openvpn/client-tcp-ohp1194.ovpn
cat /etc/openvpn/server/ca.crt >> /etc/openvpn/client-tcp-ohp1194.ovpn
echo '</ca>' >> /etc/openvpn/client-tcp-ohp1194.ovpn
cp /etc/openvpn/client-tcp-ohp1194.ovpn /home/vps/public_html/client-tcp-ohp1194.ovpn
clear
cd 

#Buat Service Untuk OHP Ovpn
cat > /etc/systemd/system/ohp.service <<END
[Unit]
Description=Direct Squid Proxy For OpenVPN TCP By EZ-Code
Documentation=https://t.me/EzcodeShop
Wants=network.target
After=network.target

[Service]
ExecStart=/usr/local/bin/ohp -port 8787 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:1194
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ohp
systemctl restart ohp
echo ""
echo -e "${GREEN}Done Installing OHP Server${NC}"
echo -e "Port OVPN OHP TCP: $ohpp"
echo -e "Link Download OVPN OHP: http://$MYIP:81/client-tcp-ohp1194.ovpn"
echo -e "Script By EZ-Code"