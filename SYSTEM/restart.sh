#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo -e ""
echo -e "  ======================================"
echo -e "           \e[0;32mRESTART VPN SERVICE\e[0m"
echo -e "  ======================================"
echo -e "  \e[0;32m[•1]\e[0m Restart All Services"
echo -e "  \e[0;32m[•2]\e[0m Restart OpenSSH"
echo -e "  \e[0;32m[•3]\e[0m Restart Dropbear"
echo -e "  \e[0;32m[•4]\e[0m Restart Stunnel"
echo -e "  \e[0;32m[•5]\e[0m Restart OpenVPN"
echo -e "  \e[0;32m[•6]\e[0m Restart Squid"
echo -e "  \e[0;32m[•7]\e[0m Restart Nginx"
echo -e "  \e[0;32m[•8]\e[0m Restart Xray Core"
echo -e "  \e[0;32m[•9]\e[0m Restart Wireguard"
echo -e "  \e[0;32m[10]\e[0m Restart Badvpn"
echo -e "  \e[0;32m[11]\e[0m Restart OHP Service"
echo -e "  \e[0;32m[12]\e[0m Restart WebSocket Service"
echo -e "  \e[0;32m[13]\e[0m Restart Udp Custom Service"
echo -e "  ======================================"
echo -e "  \e[0;32m[•x]\e[0m \e[1;31mMain Menu\e[0m"
echo -e ""
read -p "    Select From Options [1-13 or x] :" Restart
echo -e ""
echo -e "  ======================================"
sleep 1
clear
case $Restart in
                1)
                clear
                /etc/init.d/ssh restart
                /etc/init.d/dropbear restart
                /etc/init.d/stunnel5 restart
                /etc/init.d/openvpn restart
                systemctl restart --now openvpn-server@server-tcp-1194
                systemctl restart --now openvpn-server@server-udp-2200
                /etc/init.d/fail2ban restart
                /etc/init.d/cron restart
                /etc/init.d/nginx restart
                /etc/init.d/squid restart
				systemctl restart xray
				systemctl restart xray@none
				systemctl restart wg-quick@wg0
				systemctl restart ohp
				systemctl restart ohps
			    systemctl restart ws-https
			    systemctl restart udp-custom
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "          \e[0;32mALL Service Restarted\e[0m         "
                echo -e ""
                echo -e "======================================"
                ;;
                2)
                clear
                /etc/init.d/ssh restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "        \e[0;32mSSH Service Restarted\e[0m       "
                echo -e ""
                echo -e "======================================"
                ;;
                3)
                clear
                /etc/init.d/dropbear restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "       \e[0;32mDropbear Service Restarted\e[0m     "
                echo -e ""
                echo -e "======================================"
                ;;
                4)
                clear
                /etc/init.d/stunnel5 restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "        \e[0;32mStunnel Service Restarted\e[0m    "
                echo -e ""
                echo -e "======================================"
                ;;
                5)
                clear
                /etc/init.d/openvpn restart
                systemctl restart --now openvpn-server@server-tcp-1194
                systemctl restart --now openvpn-server@server-udp-2200
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "       \e[0;32mOpenVPN Service Restarted\e[0m      "
                echo -e ""
                echo -e "======================================"
                ;;
                6)
                clear
                /etc/init.d/squid restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "        \e[0;32mSquid3 Service Restarted\e[0m      "
                echo -e ""
                echo -e "======================================"
                ;;
                7)
                clear
                /etc/init.d/nginx restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "         \e[0;32mNginx Service Restarted\e[0m      "
                echo -e ""
                echo -e "======================================"
                ;;
				8)
                clear
				systemctl restart xray
				systemctl restart xray@none
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "         \e[0;32mXray Service Restart\e[0m         "
                echo -e ""
                echo -e "======================================"
                ;;
				9)
				clear
                systemctl restart wg-quick@wg0
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "       \e[0;32mWireguard Service Restart\e[0m     "
                echo -e ""
                echo -e "======================================"
                ;;
                10)
                clear
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "       \e[0;32mBadvpn Service Restarted\e[0m     "
                echo -e ""
                echo -e "======================================"
                ;;
				11)
				clear
                systemctl restart ohp
				systemctl restart ohps
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "         \e[0;32mOHP Service Restarted\e[0m     "
                echo -e ""
                echo -e "======================================"
				;;
				12)
				clear
				systemctl restart ws-https
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "      \e[0;32mWebSocket Service Restarted\e[0m     "
                echo -e ""
                echo -e "======================================"
				;;
				13)
				clear
				systemctl restart udp-custom
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "      \e[0;32mUdp Custom Service Restarted\e[0m     "
                echo -e ""
                echo -e "======================================"
                ;;
                x)
                clear
                menu
				exit
                ;;
                esac
echo ""
read -p "$( echo -e "Press [ ${NC}${green}Enter${NC} ${CYAN}]${NC} for back . . .") "
restart