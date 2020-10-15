#!/bin/bash

# COLORS
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

# Timezone
ln -sf /usr/share/zoneinfo/$1 /etc/localtime
sleep 2
hwclock --systohc
