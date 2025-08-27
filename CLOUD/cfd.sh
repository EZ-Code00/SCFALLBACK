#!/bin/bash
# Acc ID Clf
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
mkdir -p /root/
touch /root/mail.conf
IP=$(wget -qO- ifconfig.me/ip);
cloudflare=$(grep -c -E "^### " "/root/mail.conf")
if [[ ${cloudflare} == '0' ]]; then
        echo ""
		echo ""
		echo -e "\e[1;31mYou don't have an ID CLOUDFLARE! Please add ID Coudflare first.\e[0m"
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
menu-domain
exit
	fi
source /root/mail.conf
DOMAIN=$domain
CF_ID=$email
CF_KEY=$key
set -euo pipefail
read -p "Insert Your Subdomain :" sub
echo "Updating DNS for ${sub}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${sub}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${sub}'","content":"'${IP}'","ttl":120,"proxied":false}')
clear
echo ""
echo -e " \e[1;36mSuccesfully Add your Subdomain\e[0m"
echo -e " \e[0;34m======================================\e[0m"
echo -e " \e[0;33mDomain Name        :\e[0m $DOMAIN"
echo -e " \e[0;33mSubdomain Name     :\e[0m ${sub}"
echo -e " \e[0;33mSub + Domain (Used):\e[0m ${sub}.$DOMAIN"
echo -e " \e[0;34m======================================\e[0m"
echo -e "\e[1;36mNow You Can Add Subdomain/Host For Script\e[0m"
echo ""
echo -e "\e[0;32mDONE...!\e[0m"
echo -e "Script By EZ-Code"

echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
menu-domain