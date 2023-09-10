#!/bin/bash

# Usage: ./07_grub.sh GRUBDESTDISK INSTALLGRUB


# COLORS
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

set -ex

# Install GRUB
if [[ $2 == y* || $2 == "" || $2 == Y* ]]
then
    if [ -d /sys/firmware/efi/efivars ]
    then
        pacman -S --noconfirm grub efibootmgr sed
        cd /
        grub-install --target=x86_64-efi --efi-directory=boot --bootloader-id=Arch
    else
        pacman -S --noconfirm grub sed
        grub-install --target=i386-pc /dev/$1
    fi

    # Set different defaults
    sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub
    sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="sysrq_always_enabled=1"/g' /etc/default/grub
    echo "GRUB_SAVEDEFAULT=true" >> /etc/default/grub
    echo "GRUB_TIMEOUT_STYLE=hidden" >> /etc/default/grub
    echo "GRUB_DISABLE_SUBMENU=y" >> /etc/default/grub

    # Generate the GRUB config
    grub-mkconfig -o /boot/grub/grub.cfg
else
    echo "${red}Not${reset} installing GRUB."
fi
