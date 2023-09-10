#!/bin/bash

# COLORS
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

set -e

# Check internet access
if curl -Is https://archlinux.org/ | head -1 | grep 200
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
