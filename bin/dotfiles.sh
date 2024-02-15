#!/bin/bash

UPDATE_SYSTEM_PACKAGES=true
if [ "$1" == "--skip-update" ]; then
    UPDATE_SYSTEM_PACKAGES=false
fi

DOTFILES_DIR="$HOME/.dotfiles/"
SSH_DIR="$HOME/.ssh"
USER_EMAIL="pmbs.123@gmail.com"

print_i(){
    echo -e "\033[32m[INFO] - \033[0m${1}"
}

print_w(){
    echo -e "\033[33m[WARN] - \033[0m${1}"
}

print_e(){
    echo -e "\033[31m[ERROR] - \033[0m${1}"
}

if [ "$UPDATE_SYSTEM_PACKAGES" = true ]; then
    print_i "Updating System Packages"
    sudo apt update -y && sudo apt upgrade -y
fi

if ! [ -x "$(command -v git)" ]; then
    print_i "Git not installed, installing..."
    sudo apt install git -y
fi

if ! [ -x "$(command -v curl)" ]; then
    print_i "Curl not installed, installing..."
    sudo apt install curl -y
fi

if ! [ -x "$(command -v pip)" ]; then
    print_i "Pip not installed, installing..."
    sudo apt install python3-pip -y
fi

if ! [ -x "$(command -v python3 -m venv)" ]; then
    print_i "Python3 venv not installed, installing..."
    sudo apt install python3-venv -y
fi

if ! [ -x "$(command -v ansible)" ]; then
    print_i "Ansible not installed, installing..."
    pip3 install ansible
fi

if ! [ -x "$(command -v xclip)" ]; then
    print_i "Xclip not installed, installing..."
    sudo apt install xclip -y
fi

if ! [ -f "$SSH_DIR/id_ed25519.pub" ]; then
    print_i "Generating SSH Key..."
    ssh-keygen -t ed25519 -C "$USER_EMAIL" -N "" -f "$SSH_DIR/id_ed25519"
    print_i "SSH key generated and copied to clipboard. Please add it to your GitHub account."
    xclip -selection clipboard < "$SSH_DIR/id_ed25519.pub"
    read -p -r "Press enter to continue"
fi

if [ -d "$DOTFILES_DIR" ]; then
    print_i "Dotfiles already installed, updating..."
    cd "$DOTFILES_DIR" || exit 1
    git pull
else
    print_i "Cloning Dotfiles..."
    git clone git@github.com:PedroS235/.dotfiles.git
fi

cd "$DOTFILES_DIR" || exit 1

ansible-playbook

if [[ -f "$DOTFILES_DIR/requirements.yml" ]]; then
    cd "$DOTFILES_DIR" || exit 1
    ansible-galaxy install -r requirements.yml
fi

cd "$DOTFILES_DIR" || exit 1

ansible-playbook --diff "$DOTFILES_DIR/main.yml"
