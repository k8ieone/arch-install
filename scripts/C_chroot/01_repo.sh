#!/bin/bash

# Clone the repo into root's home
cd ~
pacman -S --noconfirm git
git clone https://github.com/satcom886/arch-install.git
rm /01_repo.sh

# Multilib and local mirror
if grep 'CARCH="x86_64"' /etc/makepkg.conf
then
	echo "Enabling Multilib"
	sed -i 's/#\[multilib\]/[multilib]/g' /etc/pacman.conf
	sed -i '/\[multilib\]/a Server = https://repo.mcld.eu/repo/archlinux/$repo/os/$arch\nInclude = /etc/pacman.d/mirrorlist' /etc/pacman.conf
	echo "Adding x86 mirror"
	sed -i '/\[core\]/a Server = https://repo.mcld.eu/repo/archlinux/$repo/os/$arch' /etc/pacman.conf
	sed -i '/\[extra\]/a Server = https://repo.mcld.eu/repo/archlinux/$repo/os/$arch' /etc/pacman.conf
elif grep 'CARCH="aarch64"' /etc/makepkg.conf
then
	echo "Adding ARM64 mirror"
	sed -i '/\[core\]/a Server = https://repo.mcld.eu/repo/arm/$arch/$repo' /etc/pacman.conf
	sed -i '/\[extra\]/a Server = https://repo.mcld.eu/repo/arm/$arch/$repo' /etc/pacman.conf
	sed -i '/\[community\]/a Server = https://repo.mcld.eu/repo/arm/$arch/$repo' /etc/pacman.conf
fi

# Enable parallel downloads
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf
