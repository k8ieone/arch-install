#!/bin/bash

set -e

# TODO: Hard-coded for now, shouldn't be too hard to make a selectable keymap
echo "KEYMAP=cz-qwertz" > /etc/vconsole.conf
