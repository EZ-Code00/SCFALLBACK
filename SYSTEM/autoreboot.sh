#!/bin/bash
#By EZ-Code
red='\e[1;31m'
green='\e[0;32m'
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'

clear
if [ ! -e /usr/local/bin/reboot ]; then
echo '#!/bin/bash' > /usr/local/bin/reboot
echo 'tanggal=$(date +"%Y-%m-%d")' >> /usr/local/bin/reboot
echo 'waktu=$(date +"%T")' >> /usr/local/bin/reboot
echo 'echo "Server successfully rebooted on the date of $tanggal hit $waktu" >> /root/log-reboot.txt' >> /usr/local/bin/reboot
echo '/sbin/shutdown -r now' >> /usr/local/bin/reboot
chmod +x /usr/local/bin/reboot
fi

# Auto Reboot
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info1="Auto Reboot set every 1 hour ${Green_font_prefix}[ON]${Font_color_suffix}"
Info2="Auto Reboot set every 6 hour ${Green_font_prefix}[ON]${Font_color_suffix}"
Info3="Auto Reboot set every 12 hours ${Green_font_prefix}[ON]${Font_color_suffix}"
Info4="Auto Reboot set every 1 day ${Green_font_prefix}[ON]${Font_color_suffix}"
Info5="Auto Reboot set every 1 week ${Green_font_prefix}[ON]${Font_color_suffix}"
Info6="Auto Reboot set every 1 month ${Green_font_prefix}[ON]${Font_color_suffix}"
Info7="Auto Reboot set Every 00.00 AM ${Green_font_prefix}[ON]${Font_color_suffix}"
Info8="Auto Reboot set Every 2.00 AM ${Green_font_prefix}[ON]${Font_color_suffix}"
Info9="Auto Reboot set Every 4.00 AM ${Green_font_prefix}[ON]${Font_color_suffix}"
Error="Auto Reboot Server ${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(cat /home/autoreboot)
function every_an_hour () {
rm -f /etc/cron.d/reboot
echo "59 * * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start1" > /home/autoreboot
echo -e "Auto-Reboot has been set every an hour"
echo -e "\e[0;32mDone\e[0m"
}
function every_6_hours () {
rm -f /etc/cron.d/reboot
echo "0 */6 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start2" > /home/autoreboot
echo -e "Auto-Reboot has been successfully set every 6 hours"
echo -e "\e[0;32mDone\e[0m"
}
function every_12_hours () {
rm -f /etc/cron.d/reboot
echo "0 */12 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start3" > /home/autoreboot
echo -e "Auto-Reboot has been successfully set every 12 hours"
echo -e "\e[0;32mDone\e[0m"
}
function set_once_a_day () {
rm -f /etc/cron.d/reboot
echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start4" > /home/autoreboot
echo -e "Auto-Reboot has been successfully set once a day"
echo -e "\e[0;32mDone\e[0m"
}
function set_once_a_week () {
rm -f /etc/cron.d/reboot
echo "0 0 */7 * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start5" > /home/autoreboot
echo -e "Auto-Reboot has been successfully set once a week"
echo -e "\e[0;32mDone\e[0m"
}
function once_a_month () {
rm -f /etc/cron.d/reboot
echo "0 0 * 1 * root /sbin/reboot" > /etc/cron.d/reboot
echo "start6" > /home/autoreboot
echo -e "Auto-Reboot has been successfully set once a month"
echo -e "\e[0;32mDone\e[0m"
}
function set_every_00 () {
rm -f /etc/cron.d/reboot
echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start7" > /home/autoreboot
echo -e "Auto-Reboot has been successfully set Every 00.00am"
echo -e "\e[0;32mDone\e[0m"
}
function set_every_02 () {
rm -f /etc/cron.d/reboot
echo "0 2 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start8" > /home/autoreboot
echo -e "Auto-Reboot has been successfully set Every 02.00am"
echo -e "\e[0;32mDone\e[0m"
}
function set_every_04 () {
rm -f /etc/cron.d/reboot
echo "0 4 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start9" > /home/autoreboot
echo -e "Auto-Reboot has been successfully set Every 04.00am"
echo -e "\e[0;32mDone\e[0m"
}
function stop () {
rm -f /etc/cron.d/reboot
sleep 0.5
echo > /home/autoreboot
echo -e "Auto-Reboot has been successfully Turn Off"
echo -e "\e[0;32mDone\e[0m"
}
function deleted () {
rm -f /root/log-reboot.txt
echo "Auto Reboot Log successfully deleted!"
}

#Status Auto Reboot
if [[ "$cek" = "start1" ]]; then
sts="${Info1}"
elif [[ "$cek" = "start2" ]]; then
sts="${Info2}"
elif [[ "$cek" = "start3" ]]; then
sts="${Info3}"
elif [[ "$cek" = "start4" ]]; then
sts="${Info4}"
elif [[ "$cek" = "start5" ]]; then
sts="${Info5}"
elif [[ "$cek" = "start6" ]]; then
sts="${Info6}"
elif [[ "$cek" = "start7" ]]; then
sts="${Info7}"
elif [[ "$cek" = "start8" ]]; then
sts="${Info8}"
elif [[ "$cek" = "start9" ]]; then
sts="${Info9}"
else
sts="${Error}"
fi
clear

# Echo Shell
echo -e "   ${BLUE}=============================================== ${NC}"
echo -e "              \e[0;33mAuto Reboot Server\e[0m"
echo -e "   ${BLUE}=============================================== ${NC}"
echo -e "   \e[0;36mSTATUS :\e[0m   $sts"
echo -e "   \e[0;34m-------\e[0m"
echo -e ""
echo -e "     \e[0;36m[•1]\e[0m Set Auto-Reboot Every 1 Hour"
echo -e "     \e[0;36m[•2]\e[0m Set Auto-Reboot Every 6 Hours"
echo -e "     \e[0;36m[•3]\e[0m Set Auto-Reboot Every 12 Hours"
echo -e "     \e[0;36m[•4]\e[0m Set Auto-Reboot Once 1 Day"
echo -e "     \e[0;36m[•5]\e[0m Set Auto-Reboot Once 1 Week"
echo -e "     \e[0;36m[•6]\e[0m Set Auto-Reboot Once 1 Month"
echo -e "     \e[0;36m[•7]\e[0m Set Auto-Reboot Every 00.00 AM"
echo -e "     \e[0;36m[•8]\e[0m Set Auto-Reboot Every 2.00 AM"
echo -e "     \e[0;36m[•9]\e[0m Set Auto-Reboot Every 4.00 AM"
echo -e "     \e[0;36m[10]\e[0m Turn off Auto-Reboot Server"
echo -e "     \e[0;36m[11]\e[0m View reboot log"
echo -e "     \e[0;36m[12]\e[0m Remove reboot log"
echo -e "     \e[0;36m[•x]\e[0m \e[1;31mBack To Main Menu\e[0m"
echo -e ""
echo -e "   ${BLUE}=============================================== ${NC}"
echo -e ""
read -rp "   Please Enter The Correct Number : " -e num
if [[ "$num" = "1" ]]; then
every_an_hour
elif [[ "$num" = "2" ]]; then
every_6_hours
elif [[ "$num" = "3" ]]; then
every_12_hours
elif [[ "$num" = "4" ]]; then
set_once_a_day
elif [[ "$num" = "5" ]]; then
set_once_a_week
elif [[ "$num" = "6" ]]; then
once_a_month
elif [[ "$num" = "7" ]]; then
set_every_00
elif [[ "$num" = "8" ]]; then
set_every_02
elif [[ "$num" = "9" ]]; then
set_every_04
elif [[ "$num" = "10" ]]; then
stop
elif [[ "$num" = "11" ]]; then
if [ ! -e /root/log-reboot.txt ]; then
	echo "No reboot activity found"
	else 
	echo -e "\e[1;36mLOG REBOOT\e[0m"
	echo -e "\e[1;33m----------\e[0m"
	cat /root/log-reboot.txt
fi
elif [[ "$num" = "12" ]]; then
echo "" > /root/log-reboot.txt
echo -e "${GREEN}Auto Reboot Log successfully deleted!${NC}"
elif [[ "$num" = "x" ]]; then
menu
exit
elif [[ "$num" = "X" ]]; then
menu
exit
else
clear
echo -e "\e[1;31mYou Entered The Wrong Number, Please Try Again!\e[0m"
autoreboot
exit
fi
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
autoreboot
