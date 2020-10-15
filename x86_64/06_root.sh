#!/bin/bash

# Usage: ./06_root.sh ROOTPASS

# COLORS
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

# Change root's password
echo "root:$1"
