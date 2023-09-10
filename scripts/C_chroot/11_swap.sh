#!/bin/bash

# Usage: ./11_swaps.sh DOSWAP SWAPSIZE

set -e

if [[ $1 == y* || $1 == "" || $1 == Y* ]]
then
    pacman -S --noconfirm zram-generator
    echo "[zram0]" >> /etc/systemd/zram-generator.conf
    echo "zram-size=ram / 2" >> /etc/systemd/zram-generator.conf
fi
