#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
rm -r /root/mail.conf
clear
cd /root
read -e -p " Insert Domain (Example: ezcode.shop) :$domain" domain
if [[ ${domain} == '' ]]; then
        echo ""
		echo ""
		echo -e "\e[1;31mPlease insert your domain\e[0m"
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
menu-domain
exit
	fi
read -e -p " Insert Your Email Cloudflare :" email
if [[ ${email} == '' ]]; then
        echo ""
		echo ""
		echo -e "\e[1;31mPlease insert your email\e[0m"
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
menu-domain
exit
	fi
read -e -p " Insert Your Api Key Cloudflare :" key
if [[ ${key} == '' ]]; then
        echo ""
		echo ""
		echo -e "\e[1;31mPlease insert your api key cloudflare\e[0m"
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
menu-domain
exit
	fi
echo -e "domain=$domain" >> /root/mail.conf
echo -e "email=$email" >> /root/mail.conf
echo -e "key=$key" >> /root/mail.conf
echo -e "### $domain $email" >> /root/mail.conf
clear
echo -e "\e[0;32mDONE\e[0m"
echo -e "\e[0;33mYour ID Cloudflare\e[0m"
echo -e "\e[1;34m===============================\e[0m"
echo -e "\e[0;36mDOMAIN         :\e[0m $domain"
echo -e "\e[0;36mEmail          :\e[0m $email"
echo -e "\e[0;36mApi Key        :\e[0m $key"
echo -e "\e[1;34m===============================\e[0m"
echo -e "\e[0;32mNow you can use & add subdomain.\e[0m"
echo -e "\e[0;32mGo to main menu and chosee Add Subdomain to you ID Cloudflare or Pointing IP\e[0m"
echo -e "\e[0;32mto you ID Cloudflare\e[0m"
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
menu-domain
