#!/bin/bash

# Timezone
ln -sf /usr/share/zoneinfo/$1 /etc/localtime
sleep 2
hwclock --systohc
# TODO: Apparently this doesn't work in a chroot
timedatectl set-ntp true
