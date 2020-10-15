#!/bin/bash

# Clone the repo into root's home
cd ~
pacman -S --noconfirm git wget
git clone https://github.com/k8ieone/arch-install.git
rm /01_repo.sh
