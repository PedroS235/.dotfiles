#!/bin/bash

if ! which yay >/dev/null; then
    sudo pacman -S --noconfirm --needed base-devel

    git clone https://aur.archlinux.org/yay.git /tmp/yay
    curr_dir=$(pwd)
    cd /tmp/yay && makepkg -si
    cd curr_dir
fi
