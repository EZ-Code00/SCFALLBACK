#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="EZ-Code00"
#Open HTTP Puncher By EZ-Code
#Direct Proxy Squid For OpenVPN TCP
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'
MYIP=$(wget -qO- https://icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

#Update Repository VPS
#Port Server ovpn ohp
#Jika Ingiin Mengubah Port Silahkan Sesuaikan Dengan Port Yang Ada Di VPS Mu
Port_OpenVPN_TCP='22';
Port_Squid='3128';
Port_OHP='8686';
clear
#Installing ohp Server
cd 
wget -q -O /usr/local/bin/ohps "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/ohps"
chmod +x /usr/local/bin/ohps

#Buat Service Untuk OHP SSH
cat > /etc/systemd/system/ohps.service <<END
[Unit]
Description=Direct Squid Proxy For open-ssh By EZ-Code
Documentation=https://t.me/EzcodeShop
Wants=network.target
After=network.target

[Service]
ExecStart=/usr/local/bin/ohps -port 8686 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:22
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ohps
systemctl restart ohps
echo ""
echo -e "${GREEN}Done Installing OHP OpenSSH${NC}"
echo -e "Port OHP OpenSSH: $ohpp"
echo -e "Script By EZ-Code"