#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo -n > /tmp/other.txt
cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" > /tmp/login-ssh.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\\E[0;41;104m         OPEN SSH User Login         \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ID  |  Username  |  IP Address"
echo " -------------------------------"
data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);
for PID in "${data[@]}"
do
        cat /tmp/login-ssh.txt | grep "sshd\[$PID\]" > /tmp/login-ssh-pid.txt;
        NUM=`cat /tmp/login-ssh-pid.txt | wc -l`;
        USER=`cat /tmp/login-ssh-pid.txt | awk '{print $7}'`;
        IP=`cat /tmp/login-ssh-pid.txt | awk '{print $9}'`;
        if [ $NUM -eq 1 ]; then
                echo " $PID - $USER - $IP";
                echo " -------------------------------"
        fi
done
echo ""
echo ""
echo "$(systemctl status dropbear.service --no-page)" | grep -i "Password auth succeeded" > /tmp/login-db.txt;
data=( `cat /tmp/login-db.txt | awk '{print $14}' | sort | uniq`);
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\\E[0;41;104m   SSH WS/SSL/DROPBEAR User Login    \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/ipdb.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp | grep dropbear | awk '{print $5}' | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /tmp/login-db.txt | grep -w $akun | awk '{print $16}' | grep -w $ip | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipdb.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipdb.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipdb.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipdb.txt | nl)
echo "user : $akun";
echo "$jum2";
echo ""
echo "-------------------------------"
fi
done
echo ""



if [ -f "/etc/openvpn/server/openvpn-tcp.log" ]; then
        echo " "
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\\E[0;41;104m       OPENVPN TCP User Login        \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo "Username  |  IP Address  |  Connected Since";
        echo "------------------------------------";
        cat /etc/openvpn/server/openvpn-tcp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-tcp.txt
        cat /tmp/vpn-login-tcp.txt
fi
echo "------------------------------------"

if [ -f "/etc/openvpn/server/openvpn-udp.log" ]; then
        echo " "
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\\E[0;41;104m       OPENVPN UDP User Login        \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo "Username  |  IP Address  |  Connected Since";
        echo "------------------------------------";
        cat /etc/openvpn/server/openvpn-udp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-udp.txt
        cat /tmp/vpn-login-udp.txt
fi
echo "------------------------------------"




rm -rf /tmp/ipdb.txt
rm -rf /tmp/login-db.txt
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
menu-ssh