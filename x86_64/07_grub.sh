#!/bin/bash

# Usage: ./07_grub.sh GRUBDESTDISK

# Install GRUB
if [ -d /sys/firmware/efi/efivars ]
then
    pacman -S --noconfirm grub efibootmgr which
    cd /
    grub-install --target=x86_64-efi --efi-directory=boot --bootloader-id=Arch
    install -m 644 /root/arch-install/configs/system-wide/grub /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
else
    pacman -S --noconfirm grub which
    grub-install --target=i386-pc /dev/$1
    install -m 644 /root/arch-install/configs/system-wide/grub /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
fi
