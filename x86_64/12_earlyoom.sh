#!/bin/bash

# Usage: ./12_earlyoom.sh DOOOM

if [[ $1 == y* || $1 == Y* ]]
then
    pacman -S --noconfirm earlyoom
    install -m 644  /root/arch-install/configs/system-wide/earlyoom /etc/default/
fi
