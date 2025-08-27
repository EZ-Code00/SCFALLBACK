#!/bin/bash
#By EZ-Code
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
clear
echo ""
echo -ne "\033[1;32m ENTER YOUR NS FOR SLOW DNS (NAMESERVER)\033[1;37m: "; read nameserver
if [[ $nameserver == "" ]]; then
echo -e "     ${red}Please insert your nameserver${NC}"
sleep 1
add-ns
else
echo -e "     ${red}Domain entered${NC}"
clear
fi
cd /etc/slowdns
rm -f startdns.sh
rm -f restartdns.sh
rm -f infons
sleep 1
cd /etc/slowdns
touch infons
echo $nameserver > infons
sleep 1
wget https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTNGINX/main/SSH/startdns.sh
wget https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTNGINX/main/SSH/restartdns.sh
chmod +x startdns.sh
chmod +x restartdns.sh
sed -i "s;1234;$nameserver;g" /etc/slowdns/startdns.sh > /dev/null 2>&1
sed -i "s;1234;$nameserver;g" /etc/slowdns/restartdns.sh > /dev/null 2>&1
cp startdns.sh /bin/
cp restartdns.sh /bin/
echo ""
echo "Checking for existence of key"
sleep 2
echo ""
echo "      Please wait...   "
sleep 2
cd
key1="/root/server.key"
key2="/root/server.pub"
if [ -f $key1 ] && [ -f $key2 ]
then
echo ""
echo -e "Key file found!"
sleep 1
echo ""
key () {
echo "How do you want to get your key?"
echo ""
echo "[ 1 ] | Use existing key in your server"
echo "[ 2 ] | Delete file and generate new key"
echo "[ 3 ] | Delete file and use default key"
echo "[ x ] | Abort installation"
echo ""
echo -ne "Enter an option: " && read option
case $option in
1) Option1 ;;
2) Option2 ;;
3) Option3 ;;
x) OptionX ;;
*) "Unknown command" ; echo ; key;;
esac
}
Option1 () {
echo -ne "Restoring existing key..." && sleep 2 && echo "OK!"
echo ""
echo -e "FINISHING..."
echo ""
cd /etc/slowdns
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns.sh
}
Option2 () {
cd
rm server.key server.pub
echo "Generating new key"
cd /etc/slowdns/
./dns-server -gen-key -privkey-file /root/server.key -pubkey-file /root/server.pub
echo -e "FINISHING..."
echo ""
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns.sh
cd
}
Option3 () {
echo -e "Downloading default key pair..."
cd
rm server.key server.pub
wget https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTNGINX/main/server.key
wget https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTNGINX/main/server.pub
sleep 1
echo -e "Download Completed"
sleep 1
cd /etc/slowdns/
echo -e "FINISHING..."
echo ""
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns.sh
cd
}
OptionX () {
exit
}
key
else
echo -e "There is no key in the logs"
echo ""
key_gen () {
echo "How do you want to get your key?"
echo ""
echo "[ 1 ] | Generate on installation"
echo "[ 2 ] | Use the default key"
echo "[ x ] | Abort installation"
echo ""
echo -ne "Enter an option: " && read opc_key
case $opc_key in
1) opc_key1 ;;
2) opc_key2 ;;
x) opc_keyx ;;
*) "Unknown command" ; echo ; key_gen;;
esac
}
opc_key1 () {
echo "Generating your key..."
cd /etc/slowdns/
./dns-server -gen-key -privkey-file /root/server.key -pubkey-file /root/server.pub
echo -e "FINISHING..."
echo ""
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns.sh
cd
}
opc_key2 () {
echo -e "Downloading default key pair..."
cd
wget https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTNGINX/main/server.key
wget https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTNGINX/main/server.pub
sleep 1
echo -e "Download Completed"
sleep 1
cd /etc/slowdns/
echo -e "FINISHING..."
echo ""
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns.sh
cd
}
opc_keyx () {
echo "Aborting installation"
sleep 2
menu
}
key_gen
fi
systemctl start rc-local.service
systemctl restart rc-local.service
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} back to main menu . . .") "
menu