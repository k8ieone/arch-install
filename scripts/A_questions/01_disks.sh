#!/bin/bash

echo -n "Have you already mounted the install destination to /mnt? "
echo -n "(y/N): "
read -r MOUNTED
if [[ $MOUNTED == n* || $MOUNTED == "" || $MOUNTED == N* ]]
then
    # Ask for the destination partition
    echo -n "Please enter the destination partition: /dev/"
    read -r INSTALLPART
    # Check if partition exists
    if fdisk -l /dev/$INSTALLPART
    then
        :
    else
        echo
        echo "${red}Partition $1 not found${reset}"
        echo "Aborting..."
        exit 1
    fi
    # Check boot mode and ask for EFI part, if necessary
    if [ -d /sys/firmware/efi/efivars ]
    then
        echo
        echo -n "Please specify the EFI system partition: /dev/"
        read -r EFIPART
        echo "Format the EFI system partition?"
        echo "Answer \"no\" for a dualboot setup, otherwise enter \"yes\""
        echo -n "(y/n): "
        read -r EFIFORMAT
    else
        echo -n "Would you like to install GRUB? "
        echo -n "(Y/n): "
        read -r INSTALLGRUB
        if [[ $INSTALLGRUB == y* || $INSTALLGRUB == "" || $INSTALLGRUB == Y* ]]
        then
            echo -n "Please enter the destination disk (not partition) for GRUB: /dev/"
            read -r GRUBDESTDISK
        else
            :
        fi
    fi
else
    INSTALLGRUB="n"
fi
