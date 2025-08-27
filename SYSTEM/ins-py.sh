#!/bin/bash
# By EZ-Code
# ==================================================
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

white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
GitUser="Y16ZR"
clear
install_py () {
echo -e "   .--------------------------------------------------."
echo -e "   |         Do you want to install Python2 ?         |"
echo -e "   '--------------------------------------------------'"
echo -e "     ${blue}1)\e[0m Yes (Continue)"
echo -e "     ${blue}2)\e[0m No (Back to main menu)"
echo -e "    ------------------------------------"
read -p "     Please select numbers 1-2 : " SC
echo ""
if [[ $SC == "1" ]]; then
cd /usr/bin
#wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz
wget https://raw.githubusercontent.com/Y16ZR/PYTHON2/main/Python-2.7.9.tgz
sudo tar xzf Python-2.7.9.tgz
cd Python-2.7.9
sudo ./configure --enable-optimizations
sudo make altinstall

sudo ln -sfn '/usr/local/bin/python2.7' '/usr/bin/python2'
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 1

cd /usr/bin
rm -r Python-2.7.9
rm -r Python-2.7.9.tgz
menu
elif [[ $SC == "2" ]]; then
clear
menu
fi
}
install_py