#!/bin/bash
Green="\e[92;1m"
RED="\033[1;31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
NC='\e[0m'
MYIP=$(curl -sS ipv4.icanhazip.com)
#TARIKH EXP
data_ip="https://raw.githubusercontent.com/EZ-Code00/allow/main/ipvps.conf"
function checking_sc() {
rm -f /usr/bin/e
valid=$(wget -qO- $data_ip | grep $MYIP | awk '{print $4}')
echo "$valid" > /usr/bin/e
}
checking_sc
exp=$(cat /usr/bin/e)
######################################
# // DETAIL ORDER IZIN IP
#username=$(cat /usr/bin/user)
rm -f >/usr/bin/user
username=$(curl -sS https://raw.githubusercontent.com/EZ-Code00/allow/main/ipvps.conf | grep -wE $MYIP | awk '{print $2}')
echo "$username" >/usr/bin/user
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)
# CERTIFICATE STATUS
d1=$(date -d "$exp" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(( (d1 - d2) / 86400 ))
######################################
clear
# // DAYS LEFT
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
#certifacate=$(((d1 - d2) / 86400))
clear
######################################
# // GETTINGS SYSTEM
#Getting OS Information
source /etc/os-release
Versi_OS=$VERSION
Tipe=$NAME

ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

ssh_ws=$(systemctl status ws | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

dropbear_service=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

stunnel_service=$(systemctl status stunnel5 | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

clear
######################################
# // RUNNING SSH
######################################
if [[ $ssh_service == "running" ]]; then 
   status_ssh="\033[97;1mON${NC}"
else
   status_ssh="\033[91;1mOFF${NC} "
fi
######################################
# // RUNNING WEBSOCKET
######################################
if [[ $ssh_ws == "running" ]]; then
    status_ws="\033[97;1mON${NC}"
else
    status_ws="\033[91;1mOFF${NC} "
fi
######################################
# // RUNNING STUNNEL
######################################
if [[ $stunnel_service == "running" ]]; then
    status_ssl="\033[97;1mON${NC}"
else
    status_ssl="\033[91;1mOFF${NC} "
fi
######################################
# RUNNING XRAY
######################################
if [[ $xray_service == "running" ]]; then 
   status_xray="\033[97;1mON${NC}"
else
   status_xray="\033[91;1mOFF${NC} "
fi
######################################
# RUNNING NGINX
######################################
if [[ $nginx_service == "running" ]]; then 
   status_nginx="\033[97;1mON${NC}"
else
   status_nginx="\033[91;1mOFF${NC} "
fi
######################################
# RUNNING DROPBEAR
######################################
if [[ $dropbear_service == "running" ]]; then 
   status_dropbear="\033[97;1mON${NC}"
else
   status_dropbear="\033[91;1mOFF${NC} "
fi

#JUMLAH SSH
if [ -f /etc/debian_version ]; then
	UIDN=1000
elif [ -f /etc/redhat-release ]; then
	UIDN=500
else
	UIDN=500
fi
JUMLAHSSH="$(awk -F: '$3 >= '$UIDN' && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

#JUMLAH VMESS WS
JUMLAHVMESSWS=$(grep -c -E "^#vmsws " "/usr/local/etc/xray/config.json")

#JUMLAH VLESS WS
JUMLAHVLESSWS=$(grep -c -E "^#vlsws " "/usr/local/etc/xray/config.json")

#JUMLAH VLESS XTLS
JUMLAHVLESSXTLS=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")

#JUMLAH TROJAN WS
JUMLAHTROJANWS=$(grep -c -E "^### " "/usr/local/etc/xray/akuntrws.conf")

#JUMLAH WIREGUARD
source /etc/wireguard/params
JUMLAHWG=$(grep -c -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf")


LOADCPU=$(printf '%-0.00001s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
CORE=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
#cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
#cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
#cpu_usage+=" %"
DATE2=$(date -R | cut -d " " -f -5)
vnstat_profile=$(vnstat | sed -n '3p' | awk '{print $1}' | grep -o '[^:]*')
vnstat -i ${vnstat_profile} >/etc/t1
bulan=$(date +%b)
tahun=$(date +%y)
ba="'"
today=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
todayd=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
today_v=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $9}')
today_rx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $2}')
today_rxv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $3}')
today_tx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $5}')
today_txv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $6}')
if [ "$(grep -wc ${bulan} /etc/t1)" != '0' ]; then
bulan=$(date +%b)
month=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $9}')
month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $10}')
month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $3}')
month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $4}')
month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $6}')
month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan $ba$tahun" | awk '{print $7}')
else
bulan2=$(date +%Y-%m)
month=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $8}')
month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $9}')
month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $2}')
month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $3}')
month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $5}')
month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan2 " | awk '{print $6}')
fi
if [ "$(grep -wc yesterday /etc/t1)" != '0' ]; then
yesterday=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $8}')
yesterday_v=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $9}')
yesterday_rx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $2}')
yesterday_rxv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $3}')
yesterday_tx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $5}')
yesterday_txv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $6}')
else
yesterday=NULL
yesterday_v=NULL
yesterday_rx=NULL
yesterday_rxv=NULL
yesterday_tx=NULL
yesterday_txv=NULL
fi

clear
echo -e " \033[94;1m╭════════════════════════════════════════════════════════╮${NC}"
echo -e " \e[94;1m│\e[0m \033[1;37m               WELCOME TO PREMIUM SCRIPT               \e[94;1m│"
echo -e " \033[94;1m╰════════════════════════════════════════════════════════╯${NC}"
function Service_System_Operating() {
echo -e " \033[94;1m      ══════════════════════════════════════════════${NC}"
echo -e " \033[1;37m  $NC\033[1;37m    ❈ DATE & TIME  \033[1;37m: ${WH}$DATE2 ${NC}"
echo -e " \033[1;37m  $NC\033[1;37m    ❈ OS           \033[1;37m: $NAME $Versi_OS"
echo -e " \033[1;37m  $NC\033[1;37m    ❈ RAM          \033[1;37m: $(free -m | awk 'NR==2 {print $2}')    \033[0m "
echo -e " \033[1;37m  $NC\033[1;37m    ❈ UPTIME       \033[1;37m: $(uptime -p | cut -d " " -f 2-10)\033[0m "
ispfile="/usr/bin/detailserver.conf"
if test -f "$ispfile"; then
isp="$(cat /usr/bin/detailserver.conf | head -n1)"
echo -e " \033[1;37m  $NC\033[1;37m    ❈ ISP          \033[1;37m: $isp  \033[0m "
fi
countryfile="/usr/bin/detailserver.conf"
if test -f "$countryfile"; then
country=$(grep -E "^## " "/usr/bin/detailserver.conf" | cut -d ' ' -f 2 )
city=$(grep -E "^### " "/usr/bin/detailserver.conf" | cut -d ' ' -f 2 )
echo -e " \033[1;37m  $NC\033[1;37m    ❈ CITY         \033[1;37m: $city ($country)"
fi
echo -e " \033[1;37m  $NC\033[1;37m    ❈ CPU          \033[1;37m: \033[1;37m$CORE Core $cpu_usage"
echo -e " \033[1;37m  $NC\033[1;37m    ❈ IP VPS       \033[1;37m: \033[1;37m$MYIP${NC}"
echo -e " \033[1;37m  $NC\033[1;37m    ❈ DOMAIN       \033[1;37m: $(cat /usr/local/etc/xray/domain)"
echo -e " \033[94;1m      ══════════════════════════════════════════════${NC}"
}

function Service_Status() {
echo -e " \033[94;1m╭═════════════════╮╭══════════════════╮╭═════════════════╮\033[0m"
echo -e " \033[94;1m│\033[0m\e[97m  SSH$NC : $status_ssh" "        \e[97m   NGINX$NC : $status_nginx" "      \e[97m   XRAY$NC : $status_xray   $NC  \e[94;1m│\e[0m" 
echo -e " \033[94;1m│\033[0m\e[97m  SSH WS$NC : $status_ws" "     \e[97m   DROPBEAR$NC : $status_dropbear" "    \e[97m  STUNNEL$NC : $status_ssl  $NC\e[94;1m│\e[0m" 
echo -e " \033[94;1m╰═════════════════╯╰══════════════════╯╰═════════════════╯\033[0m"
echo -e " \033[94;1m╭════════════════════════╮╭═════════════╮╭═══════════════╮${NC}"
echo -e " \033[94;1m│$NC     \033[94;1mVPN PANEL MENU${NC}     \033[94;1m│$NC \033[94;1mTOTAL ACCOUNT ${NC}  \033[94;1mBANDWIDTH USED${NC}"
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m01\033[94;1m]${NC}\033[94;1m• \033[1;37mSSH & OPENVPN    \033[94;1m│$NC  \033[1;37m$JUMLAHSSH \033[1;37mAccounts    ${NC}     \033[94;1mTODAY ${NC}"
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m02\033[94;1m]${NC}\033[94;1m• \033[1;37mVMESS WEBSOCKET  \033[94;1m│$NC  \033[1;37m$JUMLAHVMESSWS \033[1;37mAccounts    ${NC}   \033[1;37m$today_tx \033[1;37m$today_txv${NC}"
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m03\033[94;1m]${NC}\033[94;1m• \033[1;37mVLESS WEBSOCKET  \033[94;1m│$NC  \033[1;37m$JUMLAHVLESSWS \033[1;37mAccounts    ${NC}   \033[94;1mYESTERDAY ${NC}"
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m04\033[94;1m]${NC}\033[94;1m• \033[1;37mTROJAN WEBSOCKET \033[94;1m│$NC  \033[1;37m$JUMLAHTROJANWS \033[1;37mAccounts    ${NC}   \033[1;37m$yesterday_tx \033[1;37m$yesterday_txv${NC}"
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m05\033[94;1m]${NC}\033[94;1m• \033[1;37mVLESS XTLS VISION\033[94;1m│$NC  \033[1;37m$JUMLAHVLESSXTLS \033[1;37mAccounts      ${NC} \033[94;1mTHIS MONTH ${NC}" 
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m06\033[94;1m]${NC}\033[94;1m• \033[1;37mWIREGUARD        \033[94;1m│$NC  \033[1;37m$JUMLAHWG \033[1;37mAccounts     ${NC}  \033[1;37m$month_tx \033[1;37m$month_txv${NC}"
echo -e " \033[94;1m╰════════════════════════╯╰═════════════╯╰═══════════════╯${NC}"
}

function Acces_Use_Command() {
echo -e " \033[94;1m╭═══════════════════════════╮╭═══════════════════════════╮${NC}"
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m07\033[94;1m]${NC}\033[94;1m• \033[1;37mRESTART SERVICE     \033[94;1m││$NC \033[94;1m[\033[1;37m14\033[94;1m]${NC}\033[94;1m• \033[1;37mRENEW CERT XRAY     \033[94;1m│$NC"
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m08\033[94;1m]${NC}\033[94;1m• \033[1;37mAUTO REBOOT VPS     \033[94;1m││$NC \033[94;1m[\033[1;37m15\033[94;1m]${NC}\033[94;1m• \033[1;37mSHOW PORT USED      \033[94;1m│$NC"
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m09\033[94;1m]${NC}\033[94;1m• \033[1;37mSYSTEM INFO/RUN     \033[94;1m││$NC \033[94;1m[\033[1;37m16\033[94;1m]${NC}\033[94;1m• \033[1;37mCLEAR LOG & CACHE   \033[94;1m│$NC"
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m10\033[94;1m]${NC}\033[94;1m• \033[1;37mBACKUP & RESTORE    \033[94;1m││$NC \033[94;1m[\033[1;37m17\033[94;1m]${NC}\033[94;1m• \033[1;37mUPDATE XRAY CORE    \033[94;1m│$NC"   
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m11\033[94;1m]${NC}\033[94;1m• \033[1;37mCHANGE DOMAIN       \033[94;1m││$NC \033[94;1m[\033[1;37m18\033[94;1m]${NC}\033[94;1m• \033[1;37mUPDATE SCRIPT       \033[94;1m│$NC"
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m12\033[94;1m]${NC}\033[94;1m• \033[1;37mCHANGE NAMESERVER   \033[94;1m││$NC \033[94;1m[\033[1;37m19\033[94;1m]${NC}\033[94;1m• \033[1;37mCHANGE PASSWORD     \033[94;1m│$NC"
echo -e " \033[94;1m│$NC \033[94;1m[\033[1;37m13\033[94;1m]${NC}\033[94;1m• \033[1;37mCHANGE DNS SERVER   \033[94;1m││$NC \033[94;1m[\033[1;37m20\033[94;1m]${NC}\033[94;1m• \033[1;37mREBOOT SERVER       \033[94;1m│$NC"
echo -e " \033[94;1m╰═══════════════════════════╯╰═══════════════════════════╯${NC}"
}

function Select_Display() {
echo
read -p "   Select From option [1 - 20 or x] :  " hallo
case $hallo in
1) clear ; menu-ssh ;;
2) clear ; x-vmws ;;
3) clear ; x-vlws ;;
4) clear ; x-trws ;;
5) clear ; x-vlxtls ;;
6) clear ; menu-wg ;;
7) clear ; restart ;; 
8) clear ; autoreboot ;;
9) clear ; x-systemd ;;
10) clear ; menu-br ;;
11) clear ; add-host ;;
12) clear ; add-ns ;;
13) clear ; dns ;;
14) clear ; cert ;;
15) clear ; info ;;
16) clear ; clear-log ;;
17) clear ; xray-update ;;
18) clear ; script-update ;;
19) clear ; passwd ;;
20) clear ; reboot ;;
*) menu ;;
esac
}

Service_System_Operating
Service_Status
Acces_Use_Command
Select_Display







