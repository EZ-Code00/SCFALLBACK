#!/bin/bash
#By EZ-Code

olddomain1="$(cat /home/vps/public_html/*.conf | grep -i "Endpoint" | cut -d= -f2 | cut -d: -f1 | head -n1)"
mkdir -p /usr/local/etc/xray/
touch /usr/local/etc/xray/olddomain
echo $olddomain1 > /usr/local/etc/xray/olddomain
olddomain=$(cat /usr/local/etc/xray/olddomain)
domain=$(cat /usr/local/etc/xray/domain)
fix="s/${olddomain}/$domain/g";
sed -i $fix /home/vps/public_html/*.conf;
rm -f /usr/local/etc/xray/olddomain