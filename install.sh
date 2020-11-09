#!/bin/bash

# Here we ask any questions
source scripts/A_questions/00_before.sh
source scripts/A_questions/01_disks.sh
source scripts/A_questions/02_hostname.sh
source scripts/A_questions/03_time.sh
source scripts/A_questions/04_root.sh
source scripts/A_questions/05_user.sh
source scripts/A_questions/06_components.sh
source scripts/A_questions/07_setuptypes.sh

# Here we do things based on the answers
source scripts/B_actions/00_ntp.sh
source scripts/B_actions/01_format.sh
source scripts/B_actions/02_base.sh
source scripts/B_actions/03_fstab.sh
source scripts/B_actions/04_makepkg.sh
source scripts/B_actions/05_sudo.sh
## This last script starts the scripts in C_chroot
source scripts/B_actions/06_chroot.sh

exit 0
