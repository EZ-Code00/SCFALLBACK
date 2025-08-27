#!/bin/bash
REPO=https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/
wget -O /usr/bin/ws "${REPO}SSHWS/ws"
wget -O /usr/bin/config.conf "${REPO}SSHWS/config.conf"
chmod +x /usr/bin/ws
cat > /etc/systemd/system/ws.service << END
[Unit]
Description=WebSocket SSH V1 By @EzcodeShop
Documentation=https://github.com/EZ-Code00
After=syslog.target network-online.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/bin/ws -f /usr/bin/config.conf
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=65535
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target

END

systemctl daemon-reload
systemctl enable ws.service
systemctl start ws.service
systemctl restart ws.service

