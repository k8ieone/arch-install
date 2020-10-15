#!/bin/bash

# Usage: ./09_nm.sh NMINSTALL

# COLORS
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

# Install NetworkManager
if [[ $1 == y* || $1 == "" || $1 == Y* ]]
then
    pacman -S --noconfirm networkmanager
    systemctl enable NetworkManager.service
else
    echo "${red}Not${reset} installing NetworkManager."
fi
