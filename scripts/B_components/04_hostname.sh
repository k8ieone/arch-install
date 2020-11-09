#!/bin/bash

# Usage: ./03_hostname.sh HOSTNAME

# Hostname configuration
echo $1 > /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	$1.local	$1" >> /etc/hosts
