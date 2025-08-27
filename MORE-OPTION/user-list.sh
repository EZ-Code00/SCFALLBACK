#!/bin/bash
#By EZ-Code
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
if [ -f /etc/debian_version ]; then
	UIDN=1000
elif [ -f /etc/redhat-release ]; then
	UIDN=500
else
	UIDN=500
fi
clear
echo " "
echo " "
echo "===========================================";
echo " "
echo "-----------------------------------"
echo "        USER ACCOUNTS LIST         "
echo "-----------------------------------"
echo "[USERNAME]   -   [DATE EXPIRED]  "
echo " "
while read ceklist
do
        AKUN="$(echo $ceklist | cut -d: -f1)"
        ID="$(echo $ceklist | grep -v nobody | cut -d: -f3)"
        exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
        if [[ $ID -ge $UIDN ]]; then
        printf "%-17s %2s\n" "$AKUN" "$exp"
        fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= '$UIDN' && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo "-------------------------------------"
echo "Number Of User Accounts: $JUMLAH USERS"
echo "-------------------------------------"
echo " "
echo "===========================================";
echo " ";
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
menu-ssh
