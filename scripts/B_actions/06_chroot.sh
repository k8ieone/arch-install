#!/bin/bash

# Run the script that sets up this repo inside the chroot
cp ~/arch-install/scripts/C_chroot/01_repo.sh /mnt
arch-chroot /mnt bash /01_repo.sh

# With the repo in place we can start running the individual scripts.
arch-chroot /mnt bash /root/arch-install/scripts/C_chroot/02_keymap.sh
arch-chroot /mnt bash /root/arch-install/scripts/C_chroot/03_timezone.sh $_TIMEZONE
arch-chroot /mnt bash /root/arch-install/scripts/C_chroot/04_hostname.sh $_HOSTNAME
arch-chroot /mnt bash /root/arch-install/scripts/C_chroot/05_locale.sh
arch-chroot /mnt bash /root/arch-install/scripts/C_chroot/06_root.sh $ROOTPASS
arch-chroot /mnt bash /root/arch-install/scripts/C_chroot/07_grub.sh $GRUBDESTDISK $INSTALLGRUB
arch-chroot /mnt bash /root/arch-install/scripts/C_chroot/08_ssh.sh $SSHINSTALL
arch-chroot /mnt bash /root/arch-install/scripts/C_chroot/09_nm.sh $NMINSTALL
arch-chroot /mnt bash /root/arch-install/scripts/C_chroot/10_user.sh $_USERNAME $USERPASS $SSHINSTALL
arch-chroot /mnt bash /root/arch-install/scripts/C_chroot/11_swap.sh $DOSWAP $SWAPSIZE
arch-chroot /mnt bash /root/arch-install/scripts/C_chroot/12_earlyoom.sh $DOOOM
arch-chroot /mnt bash /root/arch-install/scripts/C_chroot/13_others.sh $_USERNAME
if [[ $SETUPTYPE == "1" ]]
then
    arch-chroot /mnt bash /root/arch-install/scripts/D_setuptypes/s886_headless.sh $_USERNAME
elif [[ $SETUPTYPE == "2" ]]
then
    arch-chroot /mnt bash /root/arch-install/scripts/D_setuptypes/s886_gnome.sh $_USERNAME
fi
