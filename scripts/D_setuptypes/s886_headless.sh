#!/bin/bash

# Usage: ./s886_gnome.sh $_USERNAME

# Splash
echo "   _____      _______ _____ ____  __  __  ___   ___    __  "
echo "  / ____|  /\|__   __/ ____/ __ \|  \/  |/ _ \ / _ \  / /  "
echo " | (___   /  \  | | | |   | |  | | \  / | (_) | (_) |/ /_  "
echo "  \___ \ / /\ \ | | | |   | |  | | |\/| |> _ < > _ <| '_ \ "
echo "  ____) / ____ \| | | |___| |__| | |  | | (_) | (_) | (_) |"
echo " |_____/_/    \_\_|  \_____\____/|_|  |_|\___/ \___/ \___/ "
echo "                                                           "
echo "                                                           "
echo

# Install Ansible
pacman -S --noconfirm --needed ansible

# Install oh-my-zsh and plugins
sudo -u $1 pikaur -S --noconfirm --needed oh-my-zsh-git zsh-theme-powerlevel10k zsh-syntax-highlighting zsh-autosuggestions

# Install command line utilities
pacman -S --noconfirm --needed thefuck

# Go to the directory with playbooks
cd /root/arch-install/ansible

# Run the dotfiles playbook
sudo -u $1 ansible-playbook --connection=local --inventory 127.0.0.1, --limit 127.0.0.1 dotfiles.playbook.yaml

# Run the system configs playbook
# TODO: Create the system configs playbook
