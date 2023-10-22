#!/bin/bash

umount /mnt/boot
umount /mnt/mnt/config
umount /mnt/var/cache/pacman/pkg
umount /mnt

nbd-client -d /dev/nbd0
