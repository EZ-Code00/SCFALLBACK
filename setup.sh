#!/bin/bash
# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "\e[0;31m Please Run This Script As Root User ! \e[0m"
		exit 1
fi
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
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
   for((i=0; i<5; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.2s
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

#COLOUR
white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
NC='\e[0m'
IP_FILE="/usr/bin/.ipvps"
MYIP=$(wget -qO- ipinfo.io/ip)
echo "$MYIP" > "$IP_FILE"

secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minutes $(( ${1} % 60 )) seconds"
}
start=$(date +%s)

default_email=$( curl https://raw.githubusercontent.com/${GitUser}/email/main/default.conf )
clear
echo ""
echo -e "${blue}════════════════════════════════════════════════════════════${NC}"
echo -e "${blue}                  WELCOME TO PREMIUM SCRIPT                 ${NC}"
echo -e "${blue}════════════════════════════════════════════════════════════${NC}"
echo -e ""
echo -e "         This script will do the installation"
echo -e "                    By EZ-Code"
echo -e ""
echo -e "             ${cyan}Script made by @EzcodeShop ${red}❤️${NC}"
echo -e "${blue}════════════════════════════════════════════════════════════${NC}"
echo ""

#Nama penyedia script
echo -e "${blue}════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "   ${blue}PLEASE ENTER THE NAME OF PROVIDER SCRIPT."
read -p "   NAME : " nm
echo $nm > /home/provided
clear
echo ""
#Email domain
echo -e "${blue}════════════════════════════════════════════════════════════\e[0m"
echo -e ""
echo -e "   ${blue}PLEASE ENTER YOUR EMAIL DOMAIN CLOUFLARE."
echo -e "   \e[1;31m(Press ENTER for default email)\e[0m"
read -p "   Email : " email
default=${default_email}
new_email=$email
if [[ $email == "" ]]; then
sts=$default_email
else
sts=$new_email
fi
# email
mkdir -p /usr/local/etc/xray/
touch /usr/local/etc/xray/email
echo $sts > /usr/local/etc/xray/email

#SUBDOMAIN ENTER
echo ""
echo -e "${blue}════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "   .----------------------------------."
echo -e "   |${blue}Please select a domain type below \e[0m|"
echo -e "   '----------------------------------'"
echo -e "     ${blue}1)\e[0m Enter your Subdomain"
echo -e "     ${blue}2)\e[0m Use a random Subdomain"
echo -e "   ------------------------------------"
read -p "   Please select numbers 1-2 or Any Button(Random) : " host
echo ""
if [[ $host == "1" ]]; then
echo -e "   ${blue}Please enter your subdomain "
read -p "   Subdomain: " host1
echo $host1 > /root/domain
echo ""
elif [[ $host == "2" ]]; then
#install cf
echo ""
wget https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/cf.sh && chmod +x cf.sh && ./cf.sh
rm -f /root/cf.sh
clear
else
#install cf
echo ""
wget https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/cf.sh && chmod +x cf.sh && ./cf.sh
rm -f /root/cf.sh
clear
fi

#NAMESERVER ENTER
echo ""
echo -e "${blue}════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "   ENTER YOUR NAMESERVER (Example: ns.ezcode.shop)" 
echo ""
echo -e "   ${blue}Please enter your nameserver(NS) "
read -p "   Nameserver: " nameserver
#nameserver
mkdir -p /etc/slowdns/
touch /etc/slowdns/infons
echo $nameserver > /etc/slowdns/infons
echo ""

#INSTALL SCRIPT
clear
echo ""
echo -e "${blue}READY FOR INSTALLATION SCRIPT...\e[0m"
sleep 1
echo ""
#SIMPLE PASSWORD MINIMAL
wget -q -O /etc/pam.d/common-password "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/password"
chmod +x /etc/pam.d/common-password
echo ""
#INSTALL WEBSERVER NGINX
echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION WEBSERVER NGINX . . ."
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -q -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/nginx.conf"
mkdir -p /home/vps/public_html
wget -q -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/vps.conf"
/etc/init.d/nginx restart
echo ""
echo -e "DOWLOADING SSH & OPENVPN..."
echo ""
apt install ncurses-utils -y
#INSTALL SSH OVPN
wget -q https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/INSTALL/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh

#INSTALL WIREGUARD
echo -e "DOWLOADING WIREGUARD..."
echo ""
wget -q https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/INSTALL/wg.sh && chmod +x wg.sh && screen -S wg ./wg.sh

#INSTALL XRAY
echo -e "DOWLOADING XRAY..."
echo ""
wget -q https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/INSTALL/ins-xray.sh && chmod +x ins-xray.sh && screen -S ins-xray ./ins-xray.sh

#INSTALL SET-BR
echo -e "DOWLOADING SET-BR..."
echo ""
wget -q https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/INSTALL/set-br.sh && chmod +x set-br.sh && ./set-br.sh

#INSTALL OHP-SERVER
echo -e "DOWLOADING OHP SERVER..."
echo ""
wget -q https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/INSTALL/ohp.sh && chmod +x ohp.sh && ./ohp.sh
wget -q https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/INSTALL/ohp-ssh.sh && chmod +x ohp-ssh.sh && ./ohp-ssh.sh

#INSTALL WEBSOCKET
echo -e "DOWLOADING WEBSOCKET SERVER..."
echo ""
wget -q https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SSHWS/insshws.sh && chmod +x insshws.sh && screen -S insshws.sh ./insshws.sh
echo ""

#INSTALL UDP-CUSTOM
echo -e "DOWLOADING UDP-CUSTOM..."
echo ""
wget -q https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/UDP-CUSTOM/udp-custom.sh && chmod +x udp-custom.sh && screen -S udp-custom.sh ./udp-custom.sh
echo ""

#INSTALL SLOW DNS SERVER
echo -e "DOWLOADING SLOW DNS SERVER..."
echo ""
wget -q https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/INSTALL/slow-dns.sh && chmod +x slow-dns.sh && ./slow-dns.sh
echo ""

cd
dd if=/dev/zero of=/swapfile bs=2048 count=1048576
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile >/dev/null 2>&1
swapon /swapfile >/dev/null 2>&1
sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab

clear
echo "1;37m" > /etc/box
echo "1;34m" > /etc/line
echo "46m" > /etc/back
#remove .sh
rm -f /root/ssh-vpn.sh
rm -f /root/wg.sh
rm -f /root/ins-xray.sh
rm -f /root/set-br.sh
rm -f /root/ohp.sh
rm -f /root/ohp-ssh.sh
rm -f /root/insshws.sh
rm -f /root/udp-custom.sh
rm -f /root/slow-dns.sh

cd /usr/bin
clear
# // Download Data SSH
echo ""
echo -e "${green}Downloading Data For SSH${NC}"
echo -e "${green}Please wait...${NC}"
wget -q -O /usr/bin/add-ssh "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/ADD-USER/add-ssh.sh"
wget -q -O /usr/bin/trial "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/TRIAL-USER/trial.sh"
wget -q -O /usr/bin/del-ssh "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/DELETE-USER/del-ssh.sh"
wget -q -O /usr/bin/member "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/member.sh"
wget -q -O /usr/bin/delete "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/DELETE-USER/delete.sh"
wget -q -O /usr/bin/check-ssh "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/CHECK-USER/check-ssh.sh"
wget -q -O /usr/bin/renew-ssh "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/RENEW-USER/renew-ssh.sh"
wget -q -O /usr/bin/user-list "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MORE-OPTION/user-list.sh"
wget -q -O /usr/bin/user-lock "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MORE-OPTION/user-lock.sh"
wget -q -O /usr/bin/user-unlock "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MORE-OPTION/user-unlock.sh"
wget -q -O /usr/bin/user-password "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MORE-OPTION/user-password.sh"
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/menu.sh"
wget -q -O /usr/bin/menu-br "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MENU/menu-br.sh"
wget -q -O /usr/bin/menu-domain "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MENU/menu-domain.sh"
wget -q -O /usr/bin/menu-ssh "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MENU/menu-ssh.sh"
wget -q -O /usr/bin/add-host "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/add-host.sh"
wget -q -O /usr/bin/restart "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/restart.sh"
wget -q -O /usr/bin/speedtest "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/speedtest_cli.py"
wget -q -O /usr/bin/info "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/info.sh"
wget -q -O /usr/bin/ram "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/ram.sh"
wget -q -O /usr/bin/clear-log "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/clear-log.sh"
wget -q -O /usr/bin/xp "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/xp.sh"
wget -q -O /usr/bin/cfa "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/CLOUD/cfa.sh"
wget -q -O /usr/bin/cfd "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/CLOUD/cfd.sh"
wget -q -O /usr/bin/cfp "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/CLOUD/cfp.sh"
wget -q -O /usr/bin/swap "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/swapkvm.sh"
wget -q -O /usr/bin/infoserver "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/infoserver.sh"
wget -q -O /usr/bin/autoreboot "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/autoreboot.sh"
wget -q -O /usr/bin/add-ns "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/add-ns.sh"
wget -q -O /usr/bin/script-update "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/script-updatessh.sh"
wget -q -O /usr/bin/ins-py "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/ins-py.sh"
wget -q -O /usr/bin/duplicate "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/duplicate.sh"
wget -q -O /usr/bin/swapkvm "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/swapkvm.sh"
wget -q -O /usr/bin/fixovpn "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/fixovpn.sh"
wget -q -O /usr/bin/running "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/running.sh"
wget -q -O /usr/bin/addip "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/addip.sh"
chmod +x /usr/bin/add-ssh
chmod +x /usr/bin/trial
chmod +x /usr/bin/del-ssh
chmod +x /usr/bin/member
chmod +x /usr/bin/delete
chmod +x /usr/bin/check-ssh
chmod +x /usr/bin/renew-ssh
chmod +x /usr/bin/user-list
chmod +x /usr/bin/user-lock
chmod +x /usr/bin/user-unlock
chmod +x /usr/bin/user-password
chmod +x /usr/bin/menu
chmod +x /usr/bin/menu-br
chmod +x /usr/bin/menu-domain
chmod +x /usr/bin/menu-ssh
chmod +x /usr/bin/add-host
chmod +x /usr/bin/restart
chmod +x /usr/bin/speedtest
chmod +x /usr/bin/info
chmod +x /usr/bin/ram
chmod +x /usr/bin/clear-log
chmod +x /usr/bin/xp
chmod +x /usr/bin/cfa
chmod +x /usr/bin/cfd
chmod +x /usr/bin/cfp
chmod +x /usr/bin/swap
chmod +x /usr/bin/infoserver
chmod +x /usr/bin/autoreboot
chmod +x /usr/bin/add-ns
chmod +x /usr/bin/script-update
chmod +x /usr/bin/ins-py
chmod +x /usr/bin/duplicate
chmod +x /usr/bin/swapkvm
chmod +x /usr/bin/fixovpn
chmod +x /usr/bin/running
chmod +x /usr/bin/addip
# // Download Data Wg
echo ""
echo -e "${green}Downloading Data For Wireguard${NC}"
echo -e "${green}Please wait...${NC}"
wget -q -O /usr/bin/add-wg "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/ADD-USER/add-wg.sh"
wget -q -O /usr/bin/trial-wg "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/TRIAL-USER/trial-wg.sh"
wget -q -O /usr/bin/del-wg "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/DELETE-USER/del-wg.sh"
wget -q -O /usr/bin/check-wg "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/CHECK-USER/check-wg.sh"
wget -q -O /usr/bin/renew-wg "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/RENEW-USER/renew-wg.sh"
wget -q -O /usr/bin/menu-wg "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MENU/menu-wg.sh"
wget -q -O /usr/bin/show-wg "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SHOW-USER/show-wg.sh"
wget -q -O /usr/bin/fixwg "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/fixwg.sh"
chmod +x /usr/bin/add-wg
chmod +x /usr/bin/trial-wg
chmod +x /usr/bin/del-wg
chmod +x /usr/bin/check-wg
chmod +x /usr/bin/renew-wg
chmod +x /usr/bin/menu-wg
chmod +x /usr/bin/show-wg
chmod +x /usr/bin/fixwg
# // Download Data Xray
echo ""
echo -e "${green}Downloading Data For Xray${NC}"
echo -e "${green}Please wait...${NC}"
wget -q -O /usr/bin/add-vlws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/ADD-USER/add-vlws.sh"
wget -q -O /usr/bin/trial-vlws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/TRIAL-USER/trial-vlws.sh"
wget -q -O /usr/bin/delete-vlws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/DELETE-USER/delete-vlws.sh"
wget -q -O /usr/bin/check-vlws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/CHECK-USER/check-vlws.sh"
wget -q -O /usr/bin/renew-vlws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/RENEW-USER/renew-vlws.sh"
wget -q -O /usr/bin/show-vlws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SHOW-USER/show-vlws.sh"
chmod +x /usr/bin/add-vlws
chmod +x /usr/bin/trial-vlws
chmod +x /usr/bin/delete-vlws
chmod +x /usr/bin/check-vlws
chmod +x /usr/bin/renew-vlws
chmod +x /usr/bin/show-vlws

#PLUGIN VLESS XTLS
wget -q -O /usr/bin/add-vlxtls "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/ADD-USER/add-vlxtls.sh"
wget -q -O /usr/bin/trial-vlxtls "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/TRIAL-USER/trial-vlxtls.sh"
wget -q -O /usr/bin/delete-vlxtls "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/DELETE-USER/delete-vlxtls.sh"
wget -q -O /usr/bin/check-vlxtls "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/CHECK-USER/check-vlxtls.sh"
wget -q -O /usr/bin/renew-vlxtls "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/RENEW-USER/renew-vlxtls.sh"
wget -q -O /usr/bin/show-vlxtls "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SHOW-USER/show-vlxtls.sh"
chmod +x /usr/bin/add-vlxtls
chmod +x /usr/bin/trial-vlxtls
chmod +x /usr/bin/delete-vlxtls
chmod +x /usr/bin/check-vlxtls
chmod +x /usr/bin/renew-vlxtls
chmod +x /usr/bin/show-vlxtls

#PLUGIN VMESS WS
cd /usr/bin
wget -q -O /usr/bin/add-vmws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/ADD-USER/add-vmws.sh"
wget -q -O /usr/bin/trial-vmws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/TRIAL-USER/trial-vmws.sh"
wget -q -O /usr/bin/delete-vmws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/DELETE-USER/delete-vmws.sh"
wget -q -O /usr/bin/check-vmws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/CHECK-USER/check-vmws.sh"
wget -q -O /usr/bin/renew-vmws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/RENEW-USER/renew-vmws.sh"
wget -q -O /usr/bin/show-vmws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SHOW-USER/show-vmws.sh"
chmod +x /usr/bin/add-vmws
chmod +x /usr/bin/trial-vmws
chmod +x /usr/bin/delete-vmws
chmod +x /usr/bin/check-vmws
chmod +x /usr/bin/renew-vmws
chmod +x /usr/bin/show-vmws

#PLUGIN TROJAN WS
cd /usr/bin
wget -q -O /usr/bin/add-trws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/ADD-USER/add-trws.sh"
wget -q -O /usr/bin/trial-trws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/TRIAL-USER/trial-trws.sh"
wget -q -O /usr/bin/delete-trws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/DELETE-USER/delete-trws.sh"
wget -q -O /usr/bin/check-trws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/CHECK-USER/check-trws.sh"
wget -q -O /usr/bin/renew-trws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/RENEW-USER/renew-trws.sh"
wget -q -O /usr/bin/show-trws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SHOW-USER/show-trws.sh"
chmod +x /usr/bin/add-trws
chmod +x /usr/bin/trial-trws
chmod +x /usr/bin/delete-trws
chmod +x /usr/bin/check-trws
chmod +x /usr/bin/renew-trws
chmod +x /usr/bin/show-trws

#MENU PROTOCOL
cd /usr/bin
wget -q -O /usr/bin/x-vlws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MENU/x-vlws.sh"
wget -q -O /usr/bin/x-vlxtls "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MENU/x-vlxtls.sh"
wget -q -O /usr/bin/x-vmws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MENU/x-vmws.sh"
wget -q -O /usr/bin/x-trws "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MENU/x-trws.sh"
wget -q -O /usr/bin/x-systemd "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/MENU/x-systemd.sh"
chmod +x /usr/bin/x-vlws
chmod +x /usr/bin/x-vlxtls
chmod +x /usr/bin/x-vmws
chmod +x /usr/bin/x-trws
chmod +x /usr/bin/x-systemd

#ANY TOOLS
cd /usr/bin
wget -q -O /usr/bin/cert "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/cert.sh"
wget -q -O /usr/bin/xray-update "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/xray-update.sh"
wget -q -O /usr/bin/dns "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/dns.sh"
chmod +x /usr/bin/cert
chmod +x /usr/bin/xray-update
chmod +x /usr/bin/dns
echo ""
echo -e "${green}Downloading Data For Backup${NC}"
echo -e "${green}Please wait...${NC}"
wget -q -O /usr/bin/autobackup "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/autobackup.sh"
wget -q -O /usr/bin/backuplink "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/backuplink.sh"
wget -q -O /usr/bin/backup "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/backup.sh"
wget -q -O /usr/bin/bckp "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/bckp.sh"
wget -q -O /usr/bin/restore "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/SYSTEM/restore.sh"
chmod +x /usr/bin/autobackup
chmod +x /usr/bin/backuplink
chmod +x /usr/bin/backup
chmod +x /usr/bin/bckp
chmod +x /usr/bin/restore
echo -e "${green}DONE${NC}"
cd
#VERSION
ver=$( curl https://raw.githubusercontent.com/${GitUser}/version-scfallback/main/version.conf )
history -c
echo "$ver" > /home/ver

#INSTALL INFORMATION PORT
wget -q -O /root/log-install.txt "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/log-install.txt"
#DETAIL SERVER
NAMAISP=$( curl -s ipinfo.io/org | cut -d " " -f 2-10  )
echo -e "$NAMAISP" >> /usr/bin/detailserver.conf
COUNTRY=$( curl -s ipinfo.io/country )
echo -e "## $COUNTRY" >> /usr/bin/detailserver.conf
CITY=$( curl -s ipinfo.io/city )
echo -e "### $CITY" >> /usr/bin/detailserver.conf
echo "Installation has been completed!!"

clear
sleep 1
clear
echo -e "${blue}════════════════════════════════════════════════════\033[0m"
echo -e "${blue}      SUCCESSFULLY INSTALLED PREMIUM SCRIPT         \033[0m"
echo -e "${blue}════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "Script created by Ez-Code"
echo ""
echo -e "For private concerns/report/donations: https://t.me/EzcodeShop"
echo ""
echo ""
echo -e "[Note] DO NOT RESELL THIS SCRIPT"
echo -e "THANKS FOR BUY & SUPPORT OUR BUSINESS"
echo ""
echo -e "             \033[1;33mINSTALLATION COMPLETED!\033[0m          "
echo ""
echo ""
secs_to_human "$(($(date +%s) - ${start}))"
echo ""
echo -e "${red}Auto reboot in 5 seconds...${NC}"
echo ""
#rm -r choose.sh
rm -r setup.sh
sleep 5
reboot
