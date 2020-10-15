#!/bin/bash

# # Usage: ./06_root.sh USERNAME USERPASS

# Create the user
useradd -m $1

# Clone to the new user's home directory
cd /home/$1
git clone https://github.com/satcom886/arch-install
chown -R $1:$1 arch-install
rm -r /root/arch-install

# Change the user's password
echo "$1:$2" | chpasswd

# Add the user to groups
sudo gpasswd -a $1 dbus
sudo gpasswd -a $1 audio
sudo gpasswd -a $1 video
sudo gpasswd -a $1 wheel
sudo gpasswd -a $1 optical
sudo gpasswd -a $1 lp
sudo gpasswd -a $1 storage
