#!/bin/bash

# Usage: ./13_basics.sh DOOOM

if [[ $1 == y* || $1 == Y* ]]
then
    pacman -S --noconfirm earlyoom
    install -m 644  /root/arch-install/configs/system-wide/earlyoom /etc/default/
fi

# Install some packages
sudo pacman -S --noconfirm nano-syntax-highlighting man-pages man-db zsh crda nano make gcc patch automake autoconf pkgconf fakeroot binutils neofetch rng-tools mlocate nss-mdns
