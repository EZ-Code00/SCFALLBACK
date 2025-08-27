#!/bin/bash
#By EZ-Code

domain=$(cat /usr/local/etc/xray/domain)
olddomain=$(cat /usr/local/etc/xray/olddomain)
fix="s/$olddomain/$domain/g";

sed -i $fix /etc/openvpn/client-tcp-1194.ovpn;
sed -i $fix /etc/openvpn/client-tcp-ohp1194.ovpn;
sed -i $fix /etc/openvpn/client-udp-2200.ovpn;
sed -i $fix /etc/openvpn/client-tcp-ssl.ovpn;

cp /etc/openvpn/client-tcp-1194.ovpn /home/vps/public_html/client-tcp-1194.ovpn
cp /etc/openvpn/client-udp-2200.ovpn /home/vps/public_html/client-udp-2200.ovpn
cp /etc/openvpn/client-tcp-ssl.ovpn /home/vps/public_html/client-tcp-ssl.ovpn
cp /etc/openvpn/client-tcp-ohp1194.ovpn /home/vps/public_html/client-tcp-ohp1194.ovpn
rm -f /usr/local/etc/xray/olddomain

systemctl enable openvpn
systemctl start openvpn
/etc/init.d/openvpn restart