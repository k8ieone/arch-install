#!/bin/bash

# Usage: ./s886_gnome.sh $_USERNAME

set -e

# Install command line utilities
pacman -S --noconfirm --needed docker libvirt

systemctl enable docker.socket libvirtd.socket

gpasswd -a $1 libvirt
gpasswd -a $1 docker
