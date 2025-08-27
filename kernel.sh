#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
clear
source /etc/os-release
OS=$ID

# Memulai Update Kernel
echo "Start Updating Kernel"

# Ubuntu Version
if [[ $OS == 'ubuntu' ]]; then
wget https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kernel.sh/master/ubuntu-mainline-kernel.sh
install ubuntu-mainline-kernel.sh /usr/local/bin/
rm -f ubuntu-mainline-kernel.sh
ubuntu-mainline-kernel.sh -c

# Checking Version
if [ $ver == $now ]; then
echo "Your Kernel Is The Latest Version"A
rm -f /usr/bin/ubuntu-mainline-kernel.sh
exit 0
else
printf "y" | ubuntu-mainline-kernel.sh -i
rm -f /usr/bin/ubuntu-mainline-kernel.sh
fi

# Debian Version
elif [[ $OS == "debian" ]]; then
ver=(`apt-cache search linux-image | grep "^linux-image" | cut -d'-' -f 3-4 |tail -n1`)
now=$(uname -r | cut -d "-" -f 1-2)

# Checking Kernel
if [ $ver == $now ]; then
echo "Your Kernel Is The Latest Version"
exit 0
else
apt install linux-image-$ver-amd64
fi

# Other OS Check
elif [[ $OS == "centos" ]]; then
    echo "Not Supported For Centos!"
    exit 1
elif [[ $OS == "fedora" ]]; then
    echo "Not Supported For Fedora"
    exit 1
else
    echo "Your OS Not Support"
    exit 1
fi

# Done
echo "Your VPS Will Be Reboot In 5s"
sleep 5
reboot