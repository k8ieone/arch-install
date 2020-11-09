# Badges
![GitHub issues](https://img.shields.io/github/issues/satcom886/arch-install)
![GitHub issues by-label](https://img.shields.io/github/issues/satcom886/arch-install/bug?label=bugs)
[![CodeFactor](https://www.codefactor.io/repository/github/satcom886/arch-install/badge)](https://www.codefactor.io/repository/github/satcom886/arch-install)
# What can I do with this?
This is a set of bash scripts that will install Arch Linux for you.
# Is it ready?
This tool is undergoing a major rewrite. At the moment the "headless" setup option works. Plasma is a work in progress.
# Usage:
## Before you begin:
1. Download and boot the stock [Arch Linux ISO](https://www.archlinux.org/download/).
1. Install `git` with `pacman -Sy git`.
1. Make your partitions. I usually use `cfdisk`.
 - For Legacy BIOS installations you only need one.
 - For UEFI systems, you will also need to make a small EFI System Partition (ESP). I recommend 1GB.
4. Clone this repo and start the install script!
## What now?
Just run the `install.sh` script and follow the script's instructions.
## Customization
Feel free to customize the script to your liking. In fact, it was made to be easily customizable!
### Terminology
 - **Questions** are asked in all the files in `scripts/A_questions`.
 - All **actions** before chrooting into the install destination are done in `scripts/B_actions`.
 - Scripts that are done inside the chroot are located in `scripts/C_chroot`.
 - All customizations (like additional desktop applications, user config files, servers, etc.) are done in the very last step. All **setuptypes** are located in `scripts/D_setuptypes`. This is where I expect most customizations will be done.

# Why?
If you are installing Arch on lots of computers (like me) it can get pretty annoying and repetitive pretty quickly. This project aims to automate, or at least simplify the process.