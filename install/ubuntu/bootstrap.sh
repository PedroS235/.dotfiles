#!/usr/bin/env bash

source ../logger.sh

log_info "Bootstrapping Ubuntu Linux Distro"

# Run as root
run_as_root

# Install packages
for script in "$(dirname "$0")/packages/"*.sh; do
    log_info "Running $script..."
    bash "$script" || log_error "Failed to run $script."
done


log_info "All packages installed successfully."
