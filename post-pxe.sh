#!/bin/bash

umount /mnt/boot
umount /mnt/mnt/config
umount /mnt/var/cache/pacman/pkg

nbd-client -d /dev/nbd0
