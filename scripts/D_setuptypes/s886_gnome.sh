#!/bin/bash

# Usage: ./s886_headless.sh $_USERNAME

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

# Install some command line tools
pacman -S --noconfirm thefuck neofetch

# Install GNOME
pacman -S --noconfirm gnome

# Enable GDM
systemctl enable gdm.service

# Install and setup oh-my-zsh
# yay -S zsh-autosuggestions-git
sudo -u $1 yay --answerdiff "n" --mflags "--noconfirm" --batchinstall -S oh-my-zsh-git zsh-theme-powerlevel10k-git zsh-fast-syntax-highlighting-git
## Build a .zshrc file
echo "ZSH=/usr/share/oh-my-zsh/" > /tmp/zshrc
echo "source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme" >> /tmp/zshrc
# echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> /tmp/zsrhc
echo "source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" >> /tmp/zshrc
echo "POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true" >> /tmp/zshrc
echo "DISABLE_AUTO_UPDATE=\"true\"" >> /tmp/zshrc
echo "plugins=(git ssh-agent archlinux systemd)" >> /tmp/zshrc
echo "ZSH_CACHE_DIR=\$HOME/.cache/oh-my-zsh" >> /tmp/zshrc
echo "if [[ ! -d \$ZSH_CACHE_DIR ]]; then" >> /tmp/zshrc
echo "  mkdir \$ZSH_CACHE_DIR" >> /tmp/zshrc
echo "fi" >> /tmp/zshrc
echo "source \$ZSH/oh-my-zsh.sh" >> /tmp/zshrc
echo "PATH=\$PATH:~/.local/bin" >> /tmp/zshrc
echo "eval \$(thefuck --alias)" >> /tmp/zshrc
echo "EDITOR=nano" >> /tmp/zshrc
echo "neofetch" >> /tmp/zshrc
## Copy the file into the user's home
install -m 644 /tmp/zshrc /home/$1/.zshrc
chown $1:$1 /home/$1/.zshrc
## Change the user's default shell to zsh
chsh -s /bin/zsh $1
