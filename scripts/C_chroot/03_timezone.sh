#!/bin/bash

set -e

# Timezone
ln -sf /usr/share/zoneinfo/$1 /etc/localtime
sleep 2
hwclock --systohc
