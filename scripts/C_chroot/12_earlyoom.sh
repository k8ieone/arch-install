#!/bin/bash

# Usage: ./12_earlyoom.sh DOOOM

if [[ $1 == y* || $1 == Y* ]]
then
    echo "Installing overrides for slices"
    echo "[Slice]" >> /etc/systemd/system/-.slice
    echo "ManagedOOMSwap=kill" >> /etc/systemd/system/-.slice
    echo "[Slice]" >> /etc/systemd/system/docker.slice
    echo "ManagedOOMMemoryPressure=kill" >> /etc/systemd/system/docker.slice
    echo "[Slice]" >> /etc/systemd/system/user.slice
    echo "ManagedOOMMemoryPressure=kill" >> /etc/systemd/system/user.slice
    systemctl enable systemd-oomd
fi
