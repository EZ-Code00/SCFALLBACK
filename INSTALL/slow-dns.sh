#!/bin/bash
clear
#slowdns
nameserver=$(cat /etc/slowdns/infons)
apt install ncurses-utils -y
cd /etc/slowdns
wget -q https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/dns-server; chmod +x dns-server
sudo mv /etc/resolv.conf /etc/resolv.conf.bkp && echo "nameserver 1.1.1.1" > /etc/resolv.conf
cd /etc/slowdns
wget -q https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SSH/startdns.sh
wget -q https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SSH/restartdns.sh
chmod +x startdns.sh
chmod +x restartdns.sh
sed -i "s;1234;$nameserver;g" /etc/slowdns/startdns.sh > /dev/null 2>&1
sed -i "s;1234;$nameserver;g" /etc/slowdns/restartdns.sh > /dev/null 2>&1
cp startdns.sh /bin/
cp restartdns.sh /bin/
sleep 1
echo "Generating your key..."
cd /etc/slowdns/
./dns-server -gen-key -privkey-file /root/server.key -pubkey-file /root/server.pub
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns.sh

#INSTALL SLOW DNS SSH
cd
apt install screen -y
apt install cron -y
service cron restart
clear