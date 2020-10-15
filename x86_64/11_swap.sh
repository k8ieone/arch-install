#!/bin/bash

# Usage: ./11_swaps.sh DOSWAP SWAPSIZE

if [[ $1 == y* || $1 == Y* ]]
then
    fallocate -l $2 /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    echo "/swapfile none swap defaults 0 0" | tee -a /etc/fstab
fi
