#!/bin/bash

sudo apt install -y tmux

TPM_INSTALL_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_INSTALL_DIR" ]; then
    git clone https://github.com/tmux-plugins/tpm $TPM_INSTALL_DIR
fi

