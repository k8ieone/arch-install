#!/bin/bash

# Usage: ./09_nm.sh NMINSTALL


# COLORS
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

set -e

# Install NetworkManager
if [[ $1 == y* || $1 == "" || $1 == Y* ]]
then
    pacman -S --noconfirm networkmanager
    systemctl enable NetworkManager.service
    # Stop pings to archlinux.org
    echo "[connectivity]" >> /etc/NetworkManager/NetworkManager.conf
    echo "uri=" >> /etc/NetworkManager/NetworkManager.conf
    # Enable mDNS by default
    echo "[connection]" >> /etc/NetworkManager/conf.d/globals.conf
    echo "mdns=2" >> /etc/NetworkManager/conf.d/globals.conf
else
    echo "${red}Not${reset} installing NetworkManager."
    pacman -S --noconfirm nss-mdns
    systemctl enable avahi-daemon.service
    sed -i 's/hosts:.*/hosts: files mymachines myhostname mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] dns/g' /etc/nsswitch.conf
fi
