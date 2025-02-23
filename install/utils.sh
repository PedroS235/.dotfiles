#!/bin/bash

function get_distro_info(){
    cat /etc/*-release
}

function get_distro_name(){
    get_distro_info | grep "^NAME=" | awk -F'=' '{print $2}' | tr -d '\"'
}

function get_distro_id(){
    get_distro_info | grep "^ID=" | awk -F'=' '{print $2}'
}

function run_as_root() {
    if [[ $EUID -ne 0 ]]; then
        log_error "This script must be run as root."
        exit 1
    fi
}

function run_as_user() {
    if [[ $EUID -eq 0 ]]; then
        log_error "This script must NOT be run as root."
        exit 1
    fi
}

function switch_to_user() {
    local user="$1"
    if [[ $EUID -eq 0 ]]; then
        log_info "Switching to user: $user"
        sudo -u "$user" bash -c "$2"
    else
        log_error "Already running as a non-root user."
        exit 1
    fi
}
