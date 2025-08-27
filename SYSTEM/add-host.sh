#!/bin/bash
#By Ez-Code
white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
NC='\e[0m'
default_email=$( curl https://raw.githubusercontent.com/EZ-Code00/email/main/default.conf )
emailcf=$(cat /usr/local/etc/xray/email)

#Input Domain
clear
#STOP PORT 80 SEMENTARA
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
cek=$(netstat -nutlp | grep -w 80)
if [[ -z $cek ]]; then
clear
echo ""
echo -e "   ${green}.----------------------------------------------------."
echo -e "   |                  ${blue}ADD NEW DOMAIN${NC}                    ${green}|"
echo -e "   '----------------------------------------------------'"
echo -e "    ${green}Note: ${red}This feature is only for new domains that have"
echo -e "          naver been generated in a script."
echo ""
echo -e "     ${blue}Please Input Your Pointing Domain In Cloudflare ${green}"
read -rp "     Domain/Host: " -e host
if [[ $host == "" ]]; then
echo -e "     ${red}Please insert your domain${NC}"
sleep 1
add-host
else
echo -e "     ${red}Domain entered${NC}"
clear
fi
#rm -f /home/domain
touch /usr/local/etc/xray/olddomain
cd /usr/local/etc/xray
cp domain /usr/local/etc/xray/olddomain
rm -f /usr/local/etc/xray/domain
touch /usr/local/etc/xray/domain
echo "$host" > /usr/local/etc/xray/domain
domain=$(cat /usr/local/etc/xray/domain)
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
echo -e "\e[1;32m════════════════════════════════════════════════════════════\e[0m"
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
echo ""
echo -e "[${GREEN}Done${NC}]"
#Update Sertificate SSL
echo "Automatical Update Your Certificate SSL"
sleep 3
echo Starting Update SSL Certificate
sleep 0.5
systemctl stop xray
systemctl stop xray@none
# GENERATE CRT
/root/.acme.sh/acme.sh --server $acmeh \
        --register-account  --accountemail $emailcf
/root/.acme.sh/acme.sh --server $acmeh --issue -d $domain --standalone -k ec-256			   
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
systemctl start xray
systemctl start xray@none
systemctl restart xray
systemctl restart xray@none
systemctl restart stunnel5
fixovpn
fixwg
#Done
echo -e "[${GREEN}Done${NC}]"
else
echo -e "\e[1;32mPort 80 is used\e[0m"
echo -e "\e[1;31mBefore changing domains, make sure port 80 is not used, if you are not sure whether port 80 is in use, please type info to see the active port.\e[0m"
sleep 1
fi
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} back to main menu . . .") "
menu
