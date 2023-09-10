#!/bin/bash

# Usage: ./06_root.sh ROOTPASS

set -xe

# Change root's password
echo "root:$1" | chpasswd
