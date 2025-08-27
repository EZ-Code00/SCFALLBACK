#!/bin/bash
#Colour
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

default_email=$( curl https://raw.githubusercontent.com/EZ-Code00/email/main/default.conf )
emailcf=$(cat /usr/local/etc/xray/email)

white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
NC='\e[0m'
clear
echo ""
touch /usr/local/etc/xray/olddomain
domain=$(cat /usr/local/etc/xray/domain)
renew () {
echo -e "   ${green}.----------------------------------------------------."
echo -e "   |        ${blue}DO YOU WANT TO RENEW CERTIFICATE OR${NC}         ${green}|"
echo -e "   |        ${blue}REPLACE DOMAIN NAME FOR THIS SCRIPT${NC}         ${green}|"
echo -e "   '----------------------------------------------------'"
echo -e "    ${green}Note: ${red}This feature is only for domains that have been"
echo -e "          generated in a script."
echo ""
echo -e "     ${blue}1)\e[0m RENEW CERTIFICATE FOR DOMAIN ${domain}"
echo -e "     ${blue}2)\e[0m REPLACE DOMAIN NAME AND GENERATE NEW CERTIFICATE"
echo -e "     ${blue}3)\e[0m BACK TO MAIN MENU"
echo -e "    ------------------------------------------------------"
read -p "     Please select numbers 1-3 : " SC
echo ""
if [[ $SC == "1" ]]; then
clear
echo ""
echo -e "\e[1;32m════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "   \e[1;32mPlease enter your email Domain/Cloudflare."
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
rm -f /usr/local/etc/xray/email
echo $sts > /usr/local/etc/xray/email
clear
echo ""
echo -e "   .-----------------------------------."
echo -e "   |   \e[1;32mPlease select acme for domain\e[0m   |"
echo -e "   '-----------------------------------'"
echo -e "     \e[1;32m1)\e[0m ZeroSSL.com"
echo -e "     \e[1;32m2)\e[0m BuyPass.com"
echo -e "     \e[1;32m3)\e[0m Letsencrypt.org"
echo -e "   ------------------------------------"
read -p "   Please select numbers 1-3(Any Button Default Letsencrypt.org) : " acmee
acme1=zerossl
acme2=https://api.buypass.com/acme/directory
acme3=letsencrypt
if [[ $acmee == "1" ]]; then
echo -e "ZeroSSL.com acme is used"
acmeh=$acme1
echo ""
elif [[ $acmee == "2" ]]; then
echo -e "BuyPass.com acme is used"
acmeh=$acme2
elif [[ $acmee == "3" ]]; then
echo -e "Letsencrypt.org acme is used"
acmeh=$acme3
else
echo -e "Default acme(Letsencrypt.org) is used"
acmeh=$acme3
clear
fi
clear
echo start
sleep 0.5
echo ""
#STOP PORT 80 SEMENTARA
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
cek=$(netstat -nutlp | grep -w 80)
if [[ -z $cek ]]; then
clear
systemctl stop xray
systemctl stop xray@none
echo -e "\e[0;32mStart renew your Certificate SSL\e[0m"
sleep 1
/root/.acme.sh/acme.sh --server $acmeh \
        --register-account  --accountemail $emailcf
/root/.acme.sh/acme.sh --server $acmeh --issue -d $domain --standalone -k ec-256 --force
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
systemctl start xray
systemctl start xray@none
systemctl restart xray
systemctl restart xray@none
systemctl restart stunnel5
echo Done
sleep 0.5
echo -e "[${GREEN}Done${NC}]"
else
echo -e "\e[1;32mPort 80 is used\e[0m"
echo -e "\e[1;31mBefore renew domains, make sure port 80 is not used, if you are not sure whether port 80 is in use, please type info to see the active port.\e[0m"
sleep 1
fi
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} back to main menu . . .") "
menu

elif [[ $SC == "2" ]]; then
clear
echo ""
echo -e "${blue}════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "   ENTER YOUR SUBDOMAIN (Example: sg.ezcode.shop)" 
echo ""
echo -e "   ${blue}Please enter your subdomain "
read -p "   Subdomain: " host1
if [[ $host1 == "" ]]; then
echo -e "     ${red}Please insert your subdomain${NC}"
sleep 1
cert
else
echo -e "     ${red}Domain entered${NC}"
clear
fi
touch /usr/local/etc/xray/olddomain
cd /usr/local/etc/xray
cp domain /usr/local/etc/xray/olddomain
rm -f /usr/local/etc/xray/domain
touch /usr/local/etc/xray/domain
echo $host1 > /usr/local/etc/xray/domain
domain2=$(cat /usr/local/etc/xray/domain)

echo ""
echo -e "\e[1;32m════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "   \e[1;32mPlease enter your email Domain/Cloudflare."
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
rm -f /usr/local/etc/xray/email
echo $sts > /usr/local/etc/xray/email
echo ""
echo -e "   .-----------------------------------."
echo -e "   |   \e[1;32mPlease select acme for domain\e[0m   |"
echo -e "   '-----------------------------------'"
echo -e "     \e[1;32m1)\e[0m ZeroSSL.com"
echo -e "     \e[1;32m2)\e[0m BuyPass.com"
echo -e "     \e[1;32m3)\e[0m Letsencrypt.org"
echo -e "   ------------------------------------"
read -p "   Please select numbers 1-3(Any Button Default Letsencrypt.org) : " acmee
acme1=zerossl
acme2=https://api.buypass.com/acme/directory
acme3=letsencrypt
if [[ $acmee == "1" ]]; then
echo -e "ZeroSSL.com acme is used"
acmeh=$acme1
echo ""
elif [[ $acmee == "2" ]]; then
echo -e "BuyPass.com acme is used"
acmeh=$acme2
elif [[ $acmee == "3" ]]; then
echo -e "Letsencrypt.org acme is used"
acmeh=$acme3
else
echo -e "Default acme(Letsencrypt.org) is used"
acmeh=$acme3
clear
fi

#STOP PORT 80 SEMENTARA
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
clear
echo start
sleep 0.5
echo ""
cek=$(netstat -nutlp | grep -w 80)
if [[ -z $cek ]]; then
clear
echo -e "\e[0;32mStart renew your Certificate SSL\e[0m"
sleep 1
systemctl stop xray
systemctl stop xray@none
/root/.acme.sh/acme.sh --server $acmeh \
        --register-account  --accountemail $emailcf
/root/.acme.sh/acme.sh --server $acmeh --issue -d $domain2 --standalone -k ec-256 --force
~/.acme.sh/acme.sh --installcert -d $domain2 --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
systemctl start xray
systemctl start xray@none
systemctl restart xray
systemctl restart xray@none
systemctl restart stunnel5
fixovpn
fixwg
echo Done
sleep 0.5
echo -e "[${GREEN}Done${NC}]"
else
echo -e "\e[1;32mPort 80 is used\e[0m"
echo -e "\e[1;31mBefore renew domains, make sure port 80 is not used, if you are not sure whether port 80 is in use, please type info to see the active port.\e[0m"
sleep 1
fi
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} back to main menu . . .") "
menu

elif [[ $SC == "3" ]]; then
clear
menu
else
clear
echo False Options
renew
fi
}
renew
