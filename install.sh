#!/bin/bash

# COLORS
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

# Check internet access
if curl -Is https://www.archlinux.org/ | head -1 | grep 200
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
# TODO: Check if the timezone exists
echo -n "Enter your timezone (ex. Europe/Prague): "
read -r _TIMEZONE
## Ask about the root password
ROOTPASS="asdf"
while [[ $ROOTPASS != $ROOTPASS2 ]]
do
    echo -n "Enter your new root password: "
    read -rs ROOTPASS
    echo
    echo -n "Please enter it again: "
    read -rs ROOTPASS2
    echo
    if [[ $ROOTPASS != $ROOTPASS2 ]]
    then
        echo "${red}The passwords don't match!${reset}"
        echo "Please try again..."
    fi
done
## Ask about the username and password for the new user
echo -n "Enter your new username: "
read -r _USERNAME
USERPASS="asdf"
while [[ $USERPASS != $USERPASS2 ]]
do
    echo -n "Enter the user's new password: "
    read -rs USERPASS
    echo
    echo -n "Please enter it again: "
    read -rs USERPASS2
    echo
    if [[ $USERPASS != $USERPASS2 ]]
    then
        echo "${red}The passwords don't match!${reset}"
        echo "Please try again..."
    fi
done
## Ask about OpenSSH
echo -n "Do you want to install the OpenSSH server? "
echo -n "(Y/n): "
read -r SSHINSTALL
## Ask about NetworkManager
echo -n "Do you want to install NetworkManager? "
echo -n "(Y/n): "
read -r NMINSTALL
## Ask about SWAP
echo -n "Do you wish to setup a SWAP file? "
echo -n "(y/N): "
read -r DOSWAP
if [[ $DOSWAP == y* || $DOSWAP == Y* ]]
then
    echo -n "Enter the SWAP file size (e.g.: 2G or 512M): "
    read -r SWAPSIZE
fi
## Ask about EarlyOOM
echo -n "Do you wish to setup EarlyOOM (killing processes when running out of memory)? "
echo -n "(y/N): "
read -r DOOOM
## Ask what type of setup should be installed
echo "What setup type do you want?"
echo "Available options are:"
echo "1 - satcom886's headless setup"
echo "2 - satcom886's Plasma setup"
echo -n "You choice: "
read -r SETUPTYPE

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
pacstrap /mnt base linux linux-firmware sudo

## Generating fstab
genfstab -U /mnt >> /mnt/etc/fstab

## Enable multicore compiling in makepkg.conf
sed -i '/ MAKEFLAGS /s/^/#/' /mnt/etc/makepkg.conf
echo "MAKEFLAGS=\"-j\$(nproc)\"" >> /mnt/etc/makepkg.conf

## wheel members have sudo rights
sudo sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /mnt/etc/sudoers

## Run the script that sets up this repo inside the chroot
cp ~/arch-install/scripts/B_components/01_repo.sh /mnt
arch-chroot /mnt bash /01_repo.sh

## With the repo in place we can start running the individual scripts.
arch-chroot /mnt bash /root/arch-install/scripts/B_components/02_keymap.sh
arch-chroot /mnt bash /root/arch-install/scripts/B_components/03_timezone.sh $_TIMEZONE
arch-chroot /mnt bash /root/arch-install/scripts/B_components/04_hostname.sh $_HOSTNAME
arch-chroot /mnt bash /root/arch-install/scripts/B_components/05_locale.sh
arch-chroot /mnt bash /root/arch-install/scripts/B_components/06_root.sh $ROOTPASS
arch-chroot /mnt bash /root/arch-install/scripts/B_components/07_grub.sh $GRUBDESTDISK
arch-chroot /mnt bash /root/arch-install/scripts/B_components/08_ssh.sh $SSHINSTALL
arch-chroot /mnt bash /root/arch-install/scripts/B_components/09_nm.sh $NMINSTALL
arch-chroot /mnt bash /root/arch-install/scripts/B_components/10_user.sh $_USERNAME $USERPASS $SSHINSTALL
arch-chroot /mnt bash /root/arch-install/scripts/B_components/11_swap.sh $DOSWAP $SWAPSIZE
arch-chroot /mnt bash /root/arch-install/scripts/B_components/12_earlyoom.sh $DOOOM
arch-chroot /mnt bash /root/arch-install/scripts/B_components/13_others.sh $_USERNAME
if [[ $SETUPTYPE == "1" ]]
then
    arch-chroot /mnt bash /root/arch-install/scripts/C_setuptypes/s886_headless.sh $_USERNAME
elif [[ $SETUPTYPE == "2" ]]
then
    arch-chroot /mnt bash /root/arch-install/scripts/C_setuptypes/s886_plasma.sh
fi
exit 0
