#!/bin/bash

set -xe

nbd-client -N ${1,,} 10.0.0.3
mkfs.ext4 /dev/nbd0
mount /dev/nbd0 /mnt
mkdir /mnt/boot
mkdir -p /mnt/var/cache/pacman/pkg
mount 10.0.0.3:/srv/atftp/arch/$1 /mnt/boot
mount 10.0.0.3:/srv/nfs/pacman_cache/x86 /mnt/var/cache/pacman/pkg
