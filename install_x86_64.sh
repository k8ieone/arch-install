#!/bin/bash

# COLORS
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

# Check internet access
if [[ curl -Is http://archlinux.org/ | head -1 | grep 200 ]]
then
    :
else
    echo
    echo "${red}Internet connection not available${reset} or archlinux.org website is down"
    echo "Aborting..."
    exit 1
fi

# Set the console keymap
loadkeys cz-qwertz
echo "Keyboard layout: cz-qwertz"

# Here we ask about everything
## Ask for the destination partition
echo -n "Please enter the destination partition: /dev/"
read -r INSTALLPART
## Check if partition exists
# TODO: Silence the output of this command
if fdisk -l /dev/$INSTALLPART
then
    :
else
    echo
    echo "${red}Partition $1 not found${reset}"
    echo "Aborting..."
    exit 1
fi
## Check boot mode and ask for EFI part, if necessary
if [ -d /sys/firmware/efi/efivars ]
then
    echo
    echo -n "Please specify the EFI system partition: /dev/"
    read -r EFIPART
    echo "Format the EFI system partition?"
    echo "Answer \"no\" for a dualboot setup, otherwise enter \"yes\""
    echo -n "y/n "
    read -r EFIFORMAT
else
    echo -n "Please enter the destination disk (not partition) for GRUB: /dev/"
    read -r GRUBDESTDISK
fi
## Ask about the hostname
echo -n "Enter your desired hostname: "
read -r _HOSTNAME
## Ask about the timezone
echo -n "Enter your timezone (ex. Europe/Prague): "
read -r _TIMEZONE
## Ask about the root password
while [[ $ROOTPASS != $ROOTPASS2 ]]
do
    echo -n "Enter your new root password: "
    read -rs ROOTPASS
    echo -n "Please enter it again: "
    read -rs ROOTPASS2
    if [[ $ROOTPASS != $ROOTPASS2 ]]
    then
        echo "${red}The passwords don't match!${reset}"
        echo "Please try again..."
        echo
    fi
done
## Ask about NetworkManager and OpenSSH
echo -n "Do you want to install the OpenSSH server? "
echo -n "(Y/n): "
read -r SSHINSTALL
echo -n "Do you want to install NetworkManager? "
echo -n "(Y/n): "
read -r NMINSTALL

# Below, we actually start doing stuff.
## enable NTP
echo "Let's set the correct time"
timedatectl set-ntp true

## Partitioning
### Format and mount root
mkfs.ext4 /dev/$INSTALLPART
sleep 2
mount /dev/$INSTALLPART /mnt
### Here we format and mount the EFI partition
if  [[ $EFIFORMAT == y* ]]
then
    echo "Formating EFI partition /dev/$EFIPART"
    mkfs.fat -F32 /dev/$EFIPART
    sleep 2
    mkdir /mnt/boot
    mount /dev/$EFIPART /mnt/boot
elif [[ $EFIFORMAT == n* ]]
then
    echo "Skipping formating /dev/$EFIPART"
    mkdir /mnt/boot
    mount /dev/$EFIPART /mnt/boot
fi

## Installing the base packages
# TODO: Read the package list from a config file
pacstrap /mnt base linux linux-firmware

## Generating fstab
genfstab -U /mnt >> /mnt/etc/fstab

## Enable multicore compiling in makepkg.conf
sed -i '/ MAKEFLAGS /s/^/#/' /mnt/etc/makepkg.conf
echo "MAKEFLAGS=\"-j\$(nproc)\"" >> /mnt/etc/makepkg.conf

## Run the script that sets up this repo inside the chroot
cp ~/arch-install/x86_64/01_repo.sh /mnt
arch-chroot /mnt bash /01_repo.sh

## With the repo in place we can start running the individual scripts.
arch-chroot /mnt bash /root/arch-install/02_keymap.sh
arch-chroot /mnt bash /root/arch-install/03_timezone.sh $_TIMEZONE
arch-chroot /mnt bash /root/arch-install/04_hostname.sh $_HOSTNAME
arch-chroot /mnt bash /root/arch-install/05_locale.sh
arch-chroot /mnt bash /root/arch-install/06_root.sh $ROOTPASS
arch-chroot /mnt bash /root/arch-install/07_grub.sh $GRUBDESTDISK
arch-chroot /mnt bash /root/arch-install/08_ssh.sh $SSHINSTALL
arch-chroot /mnt bash /root/arch-install/09_nm.sh $NMINSTALL
exit 0
