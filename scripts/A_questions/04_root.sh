#!/bin/bash

# Ask about the root password
ROOTPASS="asdf"
while [[ $ROOTPASS != $ROOTPASS2 ]]
do
    echo -n "Enter your new root password: "
    read -rs ROOTPASS
    echo
    echo -n "Please enter it again: "
    read -rs ROOTPASS2
    echo
    if [[ $ROOTPASS != $ROOTPASS2 ]]
    then
        echo "${red}The passwords don't match!${reset}"
        echo "Please try again..."
    fi
done
