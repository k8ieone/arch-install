#!/bin/bash

# Usage: ./13_basics.sh _USERNAME

# Install some packages
sudo pacman -S --noconfirm nano-syntax-highlighting man-pages man-db zsh crda nano make gcc patch automake autoconf pkgconf fakeroot binutils rng-tools mlocate nss-mdns

# Enable nano syntax highlighting
echo "include \"/usr/share/nano/*.nanorc\"" | sudo tee -a /etc/nanorc
echo "include \"/usr/share/nano-syntax-highlighting/*.nanorc\"" | sudo tee -a /etc/nanorc

# Enable some basic services
systemctl enable rngd man-db.timer updatedb.timer

# Enable .local mDNS resolution
# Use > for overwriting the config
# and >> for appending to the config
# so I don't have to copy the config file here
install -m 644 /root/arch-install/configs/system-wide/nsswitch.conf /etc

# Install yay
cd ~
sudo -u $1 git clone https://aur.archlinux.org/yay.git
cd yay
sudo -u $1 makepkg -Asi
cd ~
rm -r yay
