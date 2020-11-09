#!/bin/bash

# Partitioning
if [[ $MOUNTED == n* || $MOUNTED == "" || $MOUNTED == N* ]]
then
    ## Format and mount root
    mkfs.ext4 /dev/$INSTALLPART
    sleep 2
    mount /dev/$INSTALLPART /mnt
    ## Here we format and mount the EFI partition
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
else
    :
fi
