#!/bin/bash

# Ask about the username and password for the new user
echo -n "Enter your new username: "
read -r _USERNAME
USERPASS="asdf"
while [[ $USERPASS != $USERPASS2 ]]
do
    echo -n "Enter the user's new password: "
    read -rs USERPASS
    echo
    echo -n "Please enter it again: "
    read -rs USERPASS2
    echo
    if [[ $USERPASS != $USERPASS2 ]]
    then
        echo "${red}The passwords don't match!${reset}"
        echo "Please try again..."
    fi
done
