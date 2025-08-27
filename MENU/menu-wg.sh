#!/bin/bash
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

#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)



#Colour
white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
clear
echo -e ""
echo -e "  ${blue}=•= WIREGUARD =•=${NC}"
echo -e ""
echo -e "  $blue[${white}1${blue}] ${white}Create account wireguard$NC"
echo -e "  $blue[${white}2${blue}] ${white}Trial account wireguard$NC"
echo -e "  $blue[${white}3${blue}] ${white}Delete account wireguard$NC"
echo -e "  $blue[${white}4${blue}] ${white}Renew account wireguard$NC"
echo -e "  $blue[${white}5${blue}] ${white}Show account wireguard$NC"
echo -e "  $blue[${white}6${blue}] ${white}Show user login account wireguard$NC"
echo -e "  $blue[${white}x${blue}] ${red}Exit/Main menu$NC"
echo -e ""
read -p "  $(echo -e     ${white}Select from options  ${blue}[${NC}1-6 or x${blue}]${NC} :)  "  wgr
echo -e ""
case $wgr in
1)
add-wg
;;
2)
trial-wg
;;
3)
del-wg
;;
4)
renew-wg
;;
5)
show-wg
;;
6)
check-wg
;;
X)
menu
;;
x)
menu
;;
*)
echo "Please enter an correct number"
sleep 1
wgr
;;
esac
