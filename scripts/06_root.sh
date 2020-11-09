#!/bin/bash

# Usage: ./06_root.sh ROOTPASS

# Change root's password
echo "root:$1" | chpasswd
