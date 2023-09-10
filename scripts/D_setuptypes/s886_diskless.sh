#!/bin/bash

# Usage: ./s886_gnome.sh $_USERNAME

set -e

# Install NFS requirements
pacman -S --noconfirm mkinitcpio-nfs-utils nfs-utils arch-install-scripts

# Add shared config mount
mkdir /mnt/config
mount 10.0.0.3:/srv/nfs/configs /mnt/config
genfstab / > /etc/fstab

# Install Telegraf
sudo -u $1 pikaur -S --noconfirm telegraf-bin
rm /etc/telegraf/telegraf.conf
ln -s /mnt/config/telegraf.conf /etc/telegraf/telegraf.conf

# Reconfigure mkinitcpio
sed -i -e 's/HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block filesystems fsck)/HOOKS=(base udev autodetect net nbd modconf kms keyboard keymap consolefont block filesystems fsck)/g' /etc/mkinitcpio.conf

# Install dependencies for netboot
sudo -u $1 pikaur -S --noconfirm mkinitcpio-nbd
