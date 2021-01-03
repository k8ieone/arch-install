#!/bin/bash

# COLORS
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

# Check internet access
if curl -Is https://archlinux.org/ | head -1 | grep 200
then
    :
else
    echo
    echo "${red}Internet connection not available${reset} or archlinux.org website is down"
    echo "Aborting..."
    exit 1
fi

# Set the console keymap
loadkeys cz-qwertz
echo "Keyboard layout: cz-qwertz"
