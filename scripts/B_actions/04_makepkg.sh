#!/bin/bash

# Enable multicore compiling in makepkg.conf
sed -i '/ MAKEFLAGS /s/^/#/' /mnt/etc/makepkg.conf
echo "MAKEFLAGS=\"-j\$(nproc)\"" >> /mnt/etc/makepkg.conf
