#!/bin/bash

sudo pacman -S --noconfirm --needed tmux

TPM_INSTALL_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_INSTALL_DIR" ]; then
    git clone https://github.com/tmux-plugins/tpm $TPM_INSTALL_DIR
fi

