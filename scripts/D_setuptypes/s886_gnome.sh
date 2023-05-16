#!/bin/bash

# Usage: ./s886_gnome.sh $_USERNAME

/root/arch-install/scripts/D_setuptypes/s886_headless.sh $1

# Install GNOME
pacman -S --noconfirm gnome

# Install fonts
pacman -S --noconfirm --needed ttf-ubuntu-mono-nerd ttf-ubuntu-font-family

# Enable GDM
systemctl enable gdm.service

# Install some additional programs
sudo -u $1 pikaur -S --noconfirm --needed mpv gnome-shell-extension-appindicator-git \
    gnome-shell-extension-caffeine-git gnome-shell-extension-clipboard-indicator-git gnome-shell-extension-freon-git \
    lite-xl lpm-git fontconfig

# Uninstall unneeded GNOME packages
pacman -Rns --noconfirm gnome-software totem gnome-music gnome-photos orca yelp gnome-user-docs

# Install Lite-XL plugins
lpm install minimap language_yaml motiontrail autoinsert bracketmatch editorconfig \
            evergreen lsp widget snippets lintplus gitdiff_highlight gitstatus \
            indentguide language_yaml language_ignore language_sh fontconfig nerdicons \
            search_ui
