#!/bin/bash

# Here we ask about some additional components.
## Ask about OpenSSH
echo -n "Do you want to install the OpenSSH server? "
echo -n "(Y/n): "
read -r SSHINSTALL
## Ask about NetworkManager
echo -n "Do you want to install NetworkManager? "
echo -n "(Y/n): "
read -r NMINSTALL
## Ask about SWAP
echo -n "Do you wish to setup zram-generator? "
echo -n "(Y/n): "
read -r DOSWAP
