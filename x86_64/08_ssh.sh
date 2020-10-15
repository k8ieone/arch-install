#!/bin/bash

# Usage: ./08_ssh.sh SSHINSTALL

# COLORS
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

# Install OpenSSH
if [[ $1 == y* || $1 == "" || $1 == Y* ]]
then
    pacman -S --noconfirm openssh
    systemctl enable sshd.service
else
    echo "${red}Not${reset} installing OpenSSH server."
fi
