#!/bin/bash

# # Usage: ./06_root.sh USERNAME USERPASS SSHINSTALL

# Create the user
useradd -m $1

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

# Generate the user's SSH keys
if [[ $3 == y* || $3 == "" || $3 == Y* ]]
then
    sudo -u $1 mkdir /home/$1/.ssh
    sudo -u $1 ssh-keygen -f /home/$1/.ssh/id_rsa -t rsa -b 4096 -N ''
fi
