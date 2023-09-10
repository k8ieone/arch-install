#!/bin/bash

# Usage: ./04_locale.sh LOCALE

set -e

# Also hard-coded for now
sed -i '/^#.*en_US.UTF-8 /s/^#//' /etc/locale.gen
sed -i '/^#.*cs_CZ.UTF-8 /s/^#//' /etc/locale.gen
echo "LOCALE=cs_CZ.UTF-8" > /etc/locale.conf
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
locale-gen
