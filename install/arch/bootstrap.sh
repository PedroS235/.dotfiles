#!/bin/bash

source ./auruser.sh

log_info "Bootstrapping ARCH Linux Distro"

# Run as root
run_as_root

# Install packages
for script in "$(dirname "$0")/packages/"*.sh; do
    log_info "Running $script..."
    bash "$script" || log_error "Failed to run $script."
done


create_aur_user

# Install yay packages
for script in "$(dirname "$0")/yay_packages/"*.sh; do
    log_info "Running $script..."
    switch_to_user "$YAY_USER" "bash $script" || log_error "Failed to run $script."
done

del_aur_user


log_info "All packages installed successfully."
