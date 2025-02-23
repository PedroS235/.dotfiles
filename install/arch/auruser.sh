#!/bin/bash
# A hack to make installation with yay not prompt the password

YAY_USER="aurhelper"

function create_aur_user(){
    if ! id "$YAY_USER" &>/dev/null; then
        log_info "Creating dedicated user for yay: $YAY_USER..."
        useradd -m -s /bin/bash "$YAY_USER" || {
            log_error "Failed to create user $YAY_USER."
            exit 1
        }
        log_success "User $YAY_USER created."
    else
        log_info "User $YAY_USER already exists."
    fi

    # Add the user to sudoers with NOPASSWD
    SUDOERS_ENTRY="$YAY_USER ALL=(ALL) NOPASSWD:ALL"
    if ! grep -q "$SUDOERS_ENTRY" /etc/sudoers; then
        log_info "Adding $YAY_USER to sudoers with NOPASSWD..."
        echo "$SUDOERS_ENTRY" | tee -a /etc/sudoers >/dev/null || {
            log_error "Failed to add $YAY_USER to sudoers."
            exit 1
        }
        log_success "$YAY_USER added to sudoers."
    else
        log_info "$YAY_USER already has NOPASSWD privileges."
    fi
}

function del_aur_user(){
    userdel -r "$YAY_USER" || {
        log_error "Failed to remove user $YAY_USER."
        exit 1
    }
}
