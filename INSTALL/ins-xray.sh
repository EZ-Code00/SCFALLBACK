#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="EZ-Code00"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)

mkdir -p /usr/local/etc/xray/
#AC TROJAN XRAY WS TLS
touch /usr/local/etc/xray/akuntrws.conf

#EMAIL & DOMAIN
emailcf=$(cat /usr/local/etc/xray/email)
domain=$(cat /root/domain)

apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Kuala_Lumpur
chronyc sourcestats -v
chronyc tracking -v
date

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION XRAY CORE . . ."

#INSTALLATION XRAY CORE
xraycore_link="https://raw.githubusercontent.com/EZ-Code00/SCFALLBACK/main/INSTALL/Xray-linux-64-v1.7.2-1.zip"

#MAKE MAIN DIRECTORY XRAY
mkdir -p /usr/bin/xray
mkdir -p /etc/xray

#UNZIP XRAY LINUX 64
cd `mktemp -d`
curl -sL "$xraycore_link" -o xray.zip
unzip -q xray.zip && rm -rf xray.zip
mv xray /usr/local/bin/xray
chmod +x /usr/local/bin/xray

#MAKE FOLDER XRAY
mkdir -p /var/log/xray/

echo -e "[ \e[32;1mINFO\e[0m ] GENERATE CERTIFICATE XRAY CORE . . ."

#STOP PORT 80 SEMENTARA
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill

#GENERATE CERTIFICATE DOMAIN FOR XRAY
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --server letsencrypt \
        --register-account  --accountemail $emailcf
/root/.acme.sh/acme.sh --server letsencrypt --issue -d $domain --standalone -k ec-256			   
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
service squid start

#UUID XRAY
uuid=$(cat /proc/sys/kernel/random/uuid)

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION CONFIGURATION FOR XRAY CORE . . ."

#MAKE CONFIG XRAY VMESS, VLESS & TROJAN WS TLS
#MAKE CONFIG XRAY VLESS XTLS VISION TLS
#MAKE CONFIG XRAY TROJAN GRPC TLS
cat> /usr/local/etc/xray/config.json  << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
       },
    "inbounds": [
        {
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "flow": "xtls-rprx-vision",
                        "level": 0
#vless-xtls
                    }
                ],
                "decryption": "none",
                "fallbacks": [
                    {
                        "dest": 1314,
                        "xver": 1
                    },
                    {
                        "path": "/trojan-ws",
                        "dest": 1313,
                        "xver": 1
                    },
                    {
                        "path": "/vmess-ws",
                        "dest": 1311,
                        "xver": 1
                    },
                    {
                        "path": "/vless-ws",
                        "dest": 1312,
                        "xver": 1
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "tls",
                "tlsSettings": {
                    "alpn": [
                        "h2",
                        "http/1.1"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/usr/local/etc/xray/xray.crt",
                            "keyFile": "/usr/local/etc/xray/xray.key"
                        }
                    ]
                }
            }
        },
        {
            "port": 1311,
            "listen": "127.0.0.1",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "alterId": 0,
                        "level": 0
#vmess-ws
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true,
                    "path": "/vmess-ws"
                }
            }
        },
        {
            "port": 1313,
            "listen": "127.0.0.1",
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "password": "xxxxxx"
#trojan-ws
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true,
                    "path": "/trojan-ws"
                }
            }
        },
        {
            "port": 1312,
            "listen": "127.0.0.1",
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "level": 0
#vless-ws
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true,
                    "path": "/vless-ws"
                }
            }
        }
    ],
    "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true
    }
  }
}
END

#MAKE CONFIG XRAY VMESS,VLESS & TROJAN NONE TLS
cat> /usr/local/etc/xray/none.json << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
      {
      "port": 80,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
              "dest": 1314,
              "xver": 1
          },
          {
              "path": "/vmess-ws",
              "dest": 1311,
              "xver": 1
          },
          {
              "path": "/vless-ws",
              "dest": 1312,
              "xver": 1
          },
          {
              "path": "/trojan-ws",
              "dest": 1313,
              "xver": 1
          }
        ]
      },
      "streamSettings": {
       "network": "tcp",
        "security": "none",
         "tcpSettings": {
          "alpn": ["http/1.1"]
                }
            }
        }
    ],
"outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true,
      "statsOutboundUplink" : true,
      "statsOutboundDownlink" : true
    }
  }
}
END

cat> /usr/local/etc/xray/vlessws.json << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
     "port": "8080",
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "1d1c1d94-6987-4658-a4dc-8821a30fe7e0",
            "level": 0,
            "email": ""
#vless-ws
          }
        ],
        "decryption": "none"
      },
      "encryption": "none",
      "streamSettings": {
        "network": "ws",
	"security": "none",
        "wsSettings": {
          "path": "/",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
		]
}
END

#Remove Old Service
rm -rf /etc/systemd/system/xray.service.d
rm -rf /etc/systemd/system/xray@.service.d

echo -e "[ \e[32;1mINFO\e[0m ] INSTALLATION XRAY CORE SERVICE . . ."

#START XRAY SERVICE TLS
cat> /etc/systemd/system/xray.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

#START XRAY SERVICE NONE TLS
cat> /etc/systemd/system/xray@.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 1311 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 1312 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 1313 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 1311 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 1312 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 1313 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

echo -e "[ \e[32;1mINFO\e[0m ] RESTART XRAY CORE . . ."
#ENABLE XRAY TLS
systemctl daemon-reload
systemctl enable xray
systemctl start xray
systemctl restart xray

#ENABLE XRAY NONE TLS
systemctl daemon-reload
systemctl enable xray@none
systemctl start xray@none
systemctl restart xray@none

systemctl daemon-reload
systemctl enable xray@vlessws
systemctl start xray@vlessws
systemctl restart xray@vlessws

cd
rm -f ins-xray.sh
mv /root/domain /usr/local/etc/xray/domain