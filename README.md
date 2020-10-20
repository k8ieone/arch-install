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
1. Install `git` with `pacman -Sy git`
1. Make your partitions. I usually use `cfdisk`
 - For Legacy BIOS installations you only need one.
 - For UEFI systems, you will also need to make a small EFI System Partition (ESP). I recommend 1GB.
3. Clone this repo and start the install script!
## What now?
Just run the `install_x86_64.sh` script and follow the script's instructions.
# Why?
If you are installing Arch on lots of computers (like me) it can get pretty annoying and repetitive pretty quickly. This project aims to automate, or at least simplify the process.