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

clear

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

echo -e "[\e[32;1mINFO\e[0m] LOADING . . ."
fun_start () {
# USERNAME
rm -f /usr/bin/user
username=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $2}' )
echo "$username" > /usr/bin/user

# Order ID
rm -f /usr/bin/ver
user=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $3}' )
echo "$user" > /usr/bin/ver

# validity
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
}
fun_bar 'fun_start'

yellow='\e[0;33m'
red="\e[1;31m"
green="\e[0;32m"
NC="\e[0m"

# VPS Information
Checkstart1=$(ip route | grep default | cut -d ' ' -f 3 | head -n 1);
if [[ $Checkstart1 == "venet0" ]]; then 
    clear
	  lan_net="venet0"
    typevps="OpenVZ"
    sleep 1
else
    clear
		lan_net="eth0"
    typevps="KVM"
    sleep 1
fi
echo -e "\e[32m Loading...\e[0m"
MYIP=$(curl -sS ipv4.icanhazip.com)
MYIP=$(wget -qO- icanhazip.com);
MYIP=$(curl -s ipinfo.io/ip )
MYIP=$(curl -sS ifconfig.me )
# VPS ISP INFORMATION
NAMAISP=$( curl -s ipinfo.io/org | cut -d " " -f 2-10  )
COUNTRY=$( curl -s ipinfo.io/country )
CITY=$( curl -s ipinfo.io/city )
WAKTUE=$( curl -s ipinfo.io/timezone )

# TOTAL RAM
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $7}' )

# DETAIL ORDER
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)

# Tipe Processor
totalcore="$(grep -c "^processor" /proc/cpuinfo)" 
totalcore+=" Core"
corediilik="$(grep -c "^processor" /proc/cpuinfo)" 
tipeprosesor="$(awk -F ': | @' '/model name|Processor|^cpu model|chip type|^cpu type/ {
                        printf $2;
                        exit
                        }' /proc/cpuinfo)"

# Shell Version
shellversion=""
shellversion=Bash
shellversion+=" Version" 
shellversion+=" ${BASH_VERSION/-*}" 
versibash=$shellversion

# Getting OS Information
source /etc/os-release
Versi_OS=$VERSION
ver=$VERSION_ID
Tipe=$NAME
URL_SUPPORT=$HOME_URL

ttoday="$(vnstat -i eth0 | grep today | awk '{print $8" "substr ($9, 1)}')"
tyest="$(vnstat -i eth0 | grep yesterday | awk '{print $8" "substr ($9, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "$(date '+%Y-%m')" | awk '{print $8" "substr ($9, 1)}')"

# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"

# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"

# Kernel Terbaru
kernelku=$(uname -r)

# Waktu Sekarang 
harini=`date -d "0 days" +"%d-%m-%Y"`
jam=`date -d "0 days" +"%X"`

# DNS Patch
tipeos2=$(uname -m)

# Getting Domain Name
Domen="$(cat /usr/local/etc/xray/domain)"

#VERSION XRAY INSTALLED ON SCRIPT
xray_version="$(xray version | head -n 1 | awk '{print $2}')"

#CHECK VERSION XRAY CORE LATEST VERSION
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"

#INSTALLATION XRAY CORE LATEST VERSION
xraycore_link="https://github.com/XTLS/Xray-core/releases/download/v$latest_version/xray-linux-64.zip"

latest="\e[0;32m[LATEST VERSION]\e[0m"
old="\e[0;31m[OLD VERSION]\e[0m"
if [ $xray_version = $latest_version ]; then
xversion=$latest
else
xversion=$old
fi

# Echoing Result
clear
echo -e ""
echo -e "              \e[1;92mYOUR SERVER INFORMATION\e[0m"
echo -e "               \e[1;92mSCRIPT VPS \e[1;96mBY EZ-CODE\e[0m"
echo -e "\e[0;33m-----------------------------------------------------------"
echo -e "                   \e[1;92mOPERATING SYSTEM\e[0m"
echo -e "  ${green}VPS Type      :${NC} $typevps"
echo -e "  ${green}OS Arch       :${NC} $tipeos2"
echo -e "  ${green}Hostname      :${NC} $HOSTNAME"
echo -e "  ${green}OS Name       :${NC} $Tipe"
echo -e "  ${green}OS Version    :${NC} $Versi_OS"
echo -e "  ${green}OS URL        :${NC} $URL_SUPPORT"
echo -e "  ${green}OS TYPE       :${NC} Linux / Unix"
echo -e "  ${green}Bash Ver      :${NC} $versibash"
echo -e "  ${green}Kernel Ver    :${NC} $kernelku"
echo -e "\e[0;33m-----------------------------------------------------------"
echo -e "                      \e[1;92mHARDWARE\e[0m"
echo -e "  ${green}Processor     :${NC} $tipeprosesor"
echo -e "  ${green}Proc Core     :${NC} $totalcore"
echo -e "  ${green}Virtual       :${NC} $typevps"
echo -e "  ${green}Cpu Usage     :${NC} $cpu_usage"
echo -e "\e[0;33m-----------------------------------------------------------"
echo -e "                 \e[1;92mSYSTEM STATUS USED"
echo -e "  ${green}Uptime        :${NC} $uptime ( From VPS Booting )"
echo -e "  ${green}Total RAM     :${NC} $tram MB"
echo -e "  ${green}Used RAM      :${NC} $uram MB"
echo -e "  ${green}Avaible RAM   :${NC} $fram MB"
echo -e "  ${green}Daily Data    :${NC} $ttoday Usage ${NC}"
echo -e "  ${green}Yesterday Data:${NC} $tyest Usage ${NC}"
echo -e "  ${green}Monthly Data  :${NC} $tmon Usage ${NC}"
echo -e "\e[0;33m-----------------------------------------------------------"
echo -e "              \e[1;92mINTERNET SERVICE PROVIDER"
echo -e "  ${green}Public Ipv4   :${NC} $MYIP"
echo -e "  ${green}Domain        :${NC} $Domen"
echo -e "  ${green}ISP Name      :${NC} $NAMAISP"
echo -e "  ${green}Country       :${NC} $COUNTRY"
echo -e "  ${green}City          :${NC} $CITY "
echo -e "${green}\e[0;33m-----------------------------------------------------------"
echo -e "                      \e[1;92mTIME & DATE"
echo -e "  ${green}Time Zone     :${NC} $WAKTUE"
echo -e "  ${green}Date          :${NC} $harini"
echo -e "  ${green}Time          :${NC} $jam ( WIB )"
echo -e "\e[0;33m-----------------------------------------------------------"
echo -e "                     \e[1;32mSTATUS SCRIPT\e[0m"
echo -e "  \e[1;36mUser          :\e[0m $username"
echo -e "  \e[1;36mOrder ID      :\e[0m $oid"
echo -e "  \e[1;36mExpired       :\e[0m $exp"
echo -e "\e[0;33m-----------------------------------------------------------"
echo -e "                     \e[1;32mXRAY VERSION"
echo -e "  ${green}XRAY VERSION  :${NC} ${xray_version} ${xversion}"
echo -e "\e[0;33m-----------------------------------------------------------"
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
x-systemd