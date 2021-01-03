#!/bin/bash

# Usage: ./13_basics.sh _USERNAME

# Install some packages
sudo pacman -S --noconfirm nano-syntax-highlighting man-pages man-db zsh crda reflector nano make gcc patch automake autoconf pkgconf fakeroot binutils rng-tools mlocate nss-mdns

# Enable nano syntax highlighting
echo "include \"/usr/share/nano/*.nanorc\"" | sudo tee -a /etc/nanorc
echo "include \"/usr/share/nano-syntax-highlighting/*.nanorc\"" | sudo tee -a /etc/nanorc

# Enable some basic services
systemctl enable rngd man-db.timer updatedb.timer systemd-resolved.service avahi-daemon.service reflector.timer

# Enable .local mDNS resolution
sed -i 's/hosts:.*/hosts: files mymachines myhostname mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] dns/g' /etc/nsswitch.conf

# Install yay
cd /home/$1
sudo -u $1 git clone https://aur.archlinux.org/yay.git
cd yay
# Don't ask when installing the dependencies
sudo -u $1 makepkg -Asi
cd /home/$1
rm -r yay

# Enable color and verbose package lists in pacman.conf
sed -i 's/#Color/Color/g' /etc/pacman.conf
sed -i 's/#VerbosePkgLists/VerbosePkgLists/g' /etc/pacman.conf
