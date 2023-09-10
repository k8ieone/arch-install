#!/bin/bash

# Usage: ./s886_gnome.sh $_USERNAME

set -e

# Install GNOME
pacman -S --noconfirm gnome gnome-tweaks

# Install fonts
pacman -S --noconfirm --needed ttf-ubuntu-mono-nerd ttf-ubuntu-font-family ttf-ubuntu-nerd

# Enable GDM
systemctl enable gdm.service

# Install some additional programs
sudo -u $1 pikaur -S --noconfirm --needed mpv gnome-shell-extension-appindicator-git \
    gnome-shell-extension-caffeine-git gnome-shell-extension-clipboard-indicator-git gnome-shell-extension-freon-git \
    pragtical ppm-git wget words

# Uninstall unneeded GNOME packages
pacman -Rns --noconfirm gnome-software totem gnome-music gnome-photos orca yelp gnome-user-docs

# Install Pragtical plugins

sudo -u $1 git clone https://github.com/pragtical/lsp /home/$1/.config/pragtical/plugins/lsp
sudo -u $1 git clone https://github.com/TorchedSammy/lite-xl-lspkind.git /home/$1/.config/pragtical/plugins/lspkind
sudo -u $1 git clone https://github.com/vqns/lite-xl-snippets.git /home/$1/.config/pragtical/plugins/lsp_snippets
sudo -u $1 wget https://raw.githubusercontent.com/pragtical/plugins/master/plugins/language_pkgbuild.lua -O /home/$1/.config/pragtical/plugins/language_pkgbuild.lua
sudo -u $1 wget https://raw.githubusercontent.com/pragtical/plugins/master/plugins/smartopenselected.lua -O /home/$1/.config/pragtical/plugins/smartopenselected.lua
sudo -u $1 wget https://raw.githubusercontent.com/pragtical/plugins/master/plugins/gitstatus.lua -O /home/$1/.config/pragtical/plugins/gitstatus.lua
sudo -u $1 wget https://raw.githubusercontent.com/pragtical/plugins/master/plugins/todotreeview.lua -O /home/$1/.config/pragtical/plugins/todotreeview.lua
sudo -u $1 ppm install minimap autoinsert bracketmatch \
            snippets lintplus \
            gitdiff_highlight selectionhighlight \
            colorpreview spellcheck memoryusage \
            copyfilelocation ghmarkdown restoretabs scalestatus typingspeed wordcount \
            indentguide nerdicons regexreplacepreview
