#!/bin/bash
# CEK UPDATE
version=$(cat /home/ver)
new_version=$( curl https://raw.githubusercontent.com/EZ-Code00/version-scfallback/main/version.conf | grep $version )
ver=$( curl https://raw.githubusercontent.com/EZ-Code00/version-scfallback/main/version.conf )
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info1="${Green_font_prefix}[$version]${Font_color_suffix}"
Info2="${Green_font_prefix}[LATEST VERSION]${Font_color_suffix}"
Error="Version ${Green_font_prefix}[$ver]${Font_color_suffix} available${Red_font_prefix}[Please Update]${Font_color_suffix}"
#Status Version
if [ $version = $new_version ]; then
sts="${Info2}"
else
sts="${Error}"
fi
clear

# Echo Shell
echo ""
echo ""
uppdatee () {
echo -e "  .-------------------------------------------------------."
echo -e "  |                    UPDATE SCRIPT MENU                 |"
echo -e "  '-------------------------------------------------------'"
echo -e "  \e[0;36mVERSION NOW \e[0;33m>>\e[0m $Info1"
echo -e "  \e[0;36mSTATUS UPDATE \e[0;33m>>\e[0m $sts"
echo -e ""
echo -e "     \e[0;36m1.\e[0m Update Script"
echo -e "  --------------------------------------------------------"
echo -e "    \e[0;32m[x]\e[0m  Back To Main Menu"
echo -e ""
echo -e ""
read -p "   Please select numbers 1 or x: " upp
if [[ $upp == "1" ]]; then
clear
cd /usr/bin
wget -O updatessh "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/updatessh.sh"
chmod +x updatessh
updatessh
elif [[ $upp == "x" ]]; then
menu
elif [[ $upp == "X" ]]; then
menu
elif [[ $upp == "" ]]; then
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
uppdatee
else
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
uppdatee
fi
}
uppdatee