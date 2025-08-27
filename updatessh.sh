#!/bin/bash
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
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.7s
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

version=$(cat /home/ver)
new_version=$( curl https://raw.githubusercontent.com/EZ-Code00/version-scfallback/main/version.conf | grep $version )
if [ $version = $new_version ]; then
clear
echo ""
echo -e "\e[1;31mChecking New Version, Please Wait...!\e[m"
sleep 3
clear
echo -e "\e[1;31mUpdate Not Available\e[m"
echo ""
clear
sleep 1
echo -e "\e[1;36mYou Have The Latest Version\e[m"
echo -e "\e[1;31mThankyou.\e[0m"
sleep 3
menu
else
clear
echo -e "\e[1;31mUpdate Available Now..\e[m"
echo -e ""
sleep 2
echo -e "\e[1;36mStart Update For New Version, Please Wait..\e[m"
sleep 2
clear
echo -e "\e[0;32mGetting New Version Script By EZ-Code...\e[0m"
sleep 1
echo ""
# RUN UPDATE
echo ""
clear
echo -e "\e[0;32mPlease Wait...!\e[0m"
sleep 6
clear
echo ""
clear
echo -e "\e[0;32mNew Version Downloading started!\e[0m"
sleep 2
fun_start () {
cd /usr/bin
#wget -O /usr/bin/menu https://raw.githubusercontent.com/EZ-Code00/FULLSCRIPTNGINX/main/menu.sh && chmod +x /usr/bin/menu
#wget -O /usr/bin/trial-vws https://raw.githubusercontent.com/EZ-Code00/FULLSCRIPTNGINX/main/TRIAL-USER/trial-vws.sh && chmod +x /usr/bin/trial-vws
#wget -O /usr/bin/path https://raw.githubusercontent.com/EZ-Code00/FULLSCRIPTNGINX/main/SYSTEM/path.sh && chmod +x /usr/bin/path
#DOWNLOAD SSH PLUGIN
wget -O add-ssh "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/ADD-USER/add-ssh.sh"
wget -O trial "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/TRIAL-USER/trial.sh"
wget -O del-ssh "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/DELETE-USER/del-ssh.sh"
wget -O member "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/member.sh"
wget -O delete "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/DELETE-USER/delete.sh"
wget -O check-ssh "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/CHECK-USER/check-ssh.sh"
wget -O renew-ssh "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/RENEW-USER/renew-ssh.sh"
wget -O autokill "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/CHECK-USER/ceklim.sh"
wget -O tendang "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/tendang.sh"
wget -O user-list "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MORE-OPTION/user-list.sh"
wget -O user-lock "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MORE-OPTION/user-lock.sh"
wget -O user-unlock "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MORE-OPTION/user-unlock.sh"
wget -O user-password "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MORE-OPTION/user-password.sh"
chmod +x add-ssh
chmod +x trial
chmod +x del-ssh
chmod +x member
chmod +x delete
chmod +x check-ssh
chmod +x renew-ssh
chmod +x autokill
chmod +x ceklim
chmod +x tendang
chmod +x user-list
chmod +x user-lock
chmod +x user-unlock
chmod +x user-password
#MENU PROTOCOL
cd /usr/bin
wget -O menu "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/menu.sh"
wget -O menu-br "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MENU/menu-br.sh"
wget -O menu-domain "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MENU/menu-domain.sh"
wget -O menu-ssh "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MENU/menu-ssh.sh"
chmod +x menu
chmod +x menu-br
chmod +x menu-domain
chmod +x menu-ssh

#SYSTEM
cd /usr/bin
wget -O add-host "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/add-host.sh"
wget -O restart "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/restart.sh"
wget -O speedtest "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/speedtest_cli.py"
wget -O info "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/info.sh"
wget -O ram "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/ram.sh"
wget -O clear-log "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/clear-log.sh"
wget -O xp "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/xp.sh"
wget -O cfa "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/CLOUD/cfa.sh"
wget -O cfd "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/CLOUD/cfd.sh"
wget -O cfp "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/CLOUD/cfp.sh"
wget -O swap "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/swapkvm.sh"
wget -O check-sc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/running.sh"
wget -O autoreboot "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/autoreboot.sh"
wget -O add-ns "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/add-ns.sh"
wget -O script-update "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/script-updatessh.sh"
wget -O ins-py "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/ins-py.sh"
wget -O duplicate "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/duplicate.sh"
wget -O fixovpn "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/fixovpn.sh"
chmod +x add-host
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x ram
chmod +x clear-log
chmod +x restore
chmod +x xp
chmod +x cfa
chmod +x cfd
chmod +x cfp
chmod +x swap
chmod +x check-sc
chmod +x autoreboot
chmod +x add-ns
chmod +x script-update
chmod +x ins-py
chmod +x duplicate
chmod +x fixovpn

# PLUGIN WG
wget -O add-wg "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/ADD-USER/add-wg.sh"
wget -O trial-wg "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/TRIAL-USER/trial-wg.sh"
wget -O del-wg "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/DELETE-USER/del-wg.sh"
wget -O check-wg "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/CHECK-USER/check-wg.sh"
wget -O renew-wg "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/RENEW-USER/renew-wg.sh"
wget -O menu-wg "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MENU/menu-wg.sh"
wget -O show-wg "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SHOW-USER/show-wg.sh"
wget -O fixwg "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/fixwg.sh"
chmod +x add-wg
chmod +x trial-wg
chmod +x del-wg
chmod +x check-wg
chmod +x renew-wg
chmod +x menu-wg
chmod +x show-wg
chmod +x fixwg

#PLUGIN VLESS WS
wget -O add-vlws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/ADD-USER/add-vlws.sh"
wget -O trial-vlws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/TRIAL-USER/trial-vlws.sh"
wget -O delete-vlws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/DELETE-USER/delete-vlws.sh"
wget -O check-vlws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/CHECK-USER/check-vlws.sh"
wget -O renew-vlws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/RENEW-USER/renew-vlws.sh"
wget -O show-vlws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SHOW-USER/show-vlws.sh"
chmod +x add-vlws
chmod +x trial-vlws
chmod +x delete-vlws
chmod +x check-vlws
chmod +x renew-vlws
chmod +x show-vlws

#PLUGIN VMESS WS
cd /usr/bin
wget -O add-vmws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/ADD-USER/add-vmws.sh"
wget -O trial-vmws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/TRIAL-USER/trial-vmws.sh"
wget -O delete-vmws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/DELETE-USER/delete-vmws.sh"
wget -O check-vmws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/CHECK-USER/check-vmws.sh"
wget -O renew-vmws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/RENEW-USER/renew-vmws.sh"
wget -O show-vmws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SHOW-USER/show-vmws.sh"
chmod +x add-vmws
chmod +x trial-vmws
chmod +x delete-vmws
chmod +x check-vmws
chmod +x renew-vmws
chmod +x show-vmws

#PLUGIN VLESS GRPC
cd /usr/bin
wget -O add-vlgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/ADD-USER/add-vlgrpc.sh"
wget -O trial-vlgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/TRIAL-USER/trial-vlgrpc.sh"
wget -O delete-vlgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/DELETE-USER/delete-vlgrpc.sh"
wget -O check-vlgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/CHECK-USER/check-vlgrpc.sh"
wget -O renew-vlgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/RENEW-USER/renew-vlgrpc.sh"
wget -O show-vlgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SHOW-USER/show-vlgrpc.sh"
chmod +x add-vlgrpc
chmod +x trial-vlgrpc
chmod +x delete-vlgrpc
chmod +x check-vlgrpc
chmod +x renew-vlgrpc
chmod +x show-vlgrpc

#PLUGIN VMESS GRPC
cd /usr/bin
wget -O add-vmgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/ADD-USER/add-vmgrpc.sh"
wget -O trial-vmgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/TRIAL-USER/trial-vmgrpc.sh"
wget -O delete-vmgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/DELETE-USER/delete-vmgrpc.sh"
wget -O check-vmgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/CHECK-USER/check-vmgrpc.sh"
wget -O renew-vmgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/RENEW-USER/renew-vmgrpc.sh"
wget -O show-vmgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SHOW-USER/show-vmgrpc.sh"
chmod +x add-vmgrpc
chmod +x trial-vmgrpc
chmod +x delete-vmgrpc
chmod +x check-vmgrpc
chmod +x renew-vmgrpc
chmod +x show-vmgrpc

#PLUGIN TROJAN WS
cd /usr/bin
wget -O add-trws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/ADD-USER/add-trws.sh"
wget -O trial-trws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/TRIAL-USER/trial-trws.sh"
wget -O delete-trws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/DELETE-USER/delete-trws.sh"
wget -O check-trws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/CHECK-USER/check-trws.sh"
wget -O renew-trws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/RENEW-USER/renew-trws.sh"
wget -O show-trws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SHOW-USER/show-trws.sh"
chmod +x add-trws
chmod +x trial-trws
chmod +x delete-trws
chmod +x check-trws
chmod +x renew-trws
chmod +x show-trws

#PLUGIN TROJAN GRPC
cd /usr/bin
wget -O add-trgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/ADD-USER/add-trgrpc.sh"
wget -O trial-trgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/TRIAL-USER/trial-trgrpc.sh"
wget -O delete-trgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/DELETE-USER/delete-trgrpc.sh"
wget -O check-trgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/CHECK-USER/check-trgrpc.sh"
wget -O renew-trgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/RENEW-USER/renew-trgrpc.sh"
wget -O show-trgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SHOW-USER/show-trgrpc.sh"
chmod +x add-trgrpc
chmod +x trial-trgrpc
chmod +x delete-trgrpc
chmod +x check-trgrpc
chmod +x renew-trgrpc
chmod +x show-trgrpc

#MENU PROTOCOL
cd /usr/bin
wget -O x-vlws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MENU/x-vlws.sh"
wget -O x-vmws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MENU/x-vmws.sh"
wget -O x-vlgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MENU/x-vlgrpc.sh"
wget -O x-vmgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MENU/x-vmgrpc.sh"
wget -O x-trws "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MENU/x-trws.sh"
wget -O x-trgrpc "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/MENU/x-trgrpc.sh"
chmod +x x-vlws
chmod +x x-vmws
chmod +x x-vlgrpc
chmod +x x-vmgrpc
chmod +x x-trws
chmod +x x-trgrpc

#ANY TOOLS
cd /usr/bin
wget -O cert "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/cert.sh"
wget -O xray-update "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/xray-update.sh"
wget -O path "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/path.sh"
wget -O dns "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/dns.sh"
chmod +x cert
chmod +x xray-update
chmod +x path
chmod +x dns

# PLUGIN B-R
cd /usr/bin
wget -O autobackup "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/autobackup.sh"
wget -O backuplink "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/backuplink.sh"
wget -O backup "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/backup.sh"
wget -O bckp "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/bckp.sh"
wget -O restore "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/SYSTEM/restore.sh"
wget -O limit-speed "https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/limit-speed.sh"
chmod +x autobackup
chmod +x backuplink
chmod +x backup
chmod +x bckp
chmod +x restore
chmod +x limit-speed

}
fun_bar 'fun_start'
echo -e ""
echo -e "\e[0;32mDownloaded successfully!\e[0m"
echo ""
ver=$( curl https://raw.githubusercontent.com/EZ-Code00/version-scnginx/main/version.conf )
sleep 1
echo -e "\e[0;32mPatching New Update, Please Wait...\e[0m"
echo ""
sleep 2
echo -e "\e[0;32mPatching... OK!\e[0m"
sleep 1
echo ""
echo -e "\e[0;32mSucces Update Script For New Version\e[0m"
cd
echo "$ver" > /home/ver
echo ""
echo -e " \e[1;31mReboot 5 Sec\e[0m"
sleep 5
rm -f update.sh
rm -rf update
reboot
fi
