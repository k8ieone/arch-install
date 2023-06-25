#!/bin/bash

# Usage: ./s886_gnome.sh $_USERNAME

/root/arch-install/scripts/D_setuptypes/s886_headless.sh $1
exit 1

# Install GNOME
pacman -S --noconfirm gnome

# Install fonts
pacman -S --noconfirm --needed ttf-ubuntu-mono-nerd ttf-ubuntu-font-family

# Enable GDM
systemctl enable gdm.service

# Install some additional programs
sudo -u $1 pikaur -S --noconfirm --needed mpv gnome-shell-extension-appindicator-git \
    gnome-shell-extension-caffeine-git gnome-shell-extension-clipboard-indicator-git gnome-shell-extension-freon-git \
    pragtical-git ppm-git fontconfig

# Uninstall unneeded GNOME packages
pacman -Rns --noconfirm gnome-software totem gnome-music gnome-photos orca yelp gnome-user-docs

# Install Pragtical plugins

sudo -u $1 git clone https://github.com/pragtical/lsp /home/$1/.config/pragtical/plugins/lsp
sudo -u $1 wget https://raw.githubusercontent.com/pragtical/plugins/master/plugins/language_pkgbuild.lua -O /home/$1/.config/pragtical/plugins/language_pkgbuild.lua
sudo -u $1 ppm install minimap autoinsert bracketmatch \
            snippets lintplus lsp_snippets lspkind smartopenselected \
            gitdiff_highlight gitstatus selectionhighlight \
            colorpreview spellcheck \
            copyfilelocation ghmarkdown restoretabs scalestatus typingspeed wordcount \
            indentguide nerdicons regexreplacepreview todotreeview \
            language_yaml \
            language_csharp language_diff \
            language_env language_ignore \
            language_ini language_java \
            language_nginx  language_powershell \
            language_psql language_toml
