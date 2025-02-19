#!/bin/bash

source ./install/logger.sh
source ./install/utils.sh


# Detecting which distro is currently in use.
DISTRO_ID=$(get_distro_id)
DISTRO_NAME=$(get_distro_name)


log_info "Detected ${DISTRO_NAME}."


# Load correct boostrap script based on current distro
source ./install/${DISTRO_ID}/bootstrap.sh
