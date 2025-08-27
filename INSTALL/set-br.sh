#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="EZ-Code00"

curl https://rclone.org/install.sh | bash
printf "q\n" | rclone config

wget -q -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/${GitUser}/SCFALLBACK/main/rclone.conf"

git clone https://github.com/magnific0/wondershaper.git
cd wondershaper

make install
cd
rm -rf wondershaper

echo > /home/limit
apt install msmtp-mta ca-certificates bsd-mailx -y

cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user ezcode2024@gmail.com
from ezcode2024@gmail.com
password eejnuabeuhgpwgtx
logfile ~/.msmtp.log
EOF

chown -R www-data:www-data /etc/msmtprc
cd
rm -f /root/set-br.sh

