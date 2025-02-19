#!/bin/bash

source ./logger.sh

function get_distro_info(){
    cat /etc/*-release
}

function get_distro_name(){
    get_distro_info | grep "^NAME=" | awk -F'=' '{print $2}' | tr -d '\"'
}

function get_distro_id(){
    get_distro_info | grep "^ID=" | awk -F'=' '{print $2}'
}
