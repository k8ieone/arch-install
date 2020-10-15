#!/bin/bash

# Usage: ./07_grub.sh GRUBDESTDISK

# COLORS
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

# Install GRUB
if [ -d /sys/firmware/efi/efivars ]
then
    pacman -S --noconfirm grub efibootmgr which
    cd /
    grub-install --target=x86_64-efi --efi-directory=boot --bootloader-id=Arch
    cp ~/rugl/bash/arch-setuptools/configs/system-wide/grub /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
else
    pacman -S --noconfirm grub which
    grub-install --target=i386-pc /dev/$1
    cp ~/rugl/bash/arch-setuptools/configs/system-wide/grub /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
fi
