#!/bin/bash

## wheel members have sudo rights
sudo sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /mnt/etc/sudoers
