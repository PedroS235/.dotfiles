#!/bin/bash

source ./install/logger.sh
source ./install/utils.sh

# Detecting which distro is currently in use.
DISTRO_ID=$(get_distro_id)
DISTRO_NAME=$(get_distro_name)

log_info "Detected ${DISTRO_NAME}."


# TODO: create directories like projects, work, tools, etc
# clone perhaps some of the projects/work stuff that is used daily

pushd $(pwd)/install/${DISTRO_ID}

source ./bootstrap.sh

popd

log_info "Stowing dotfiles"

stow .

log_info "Complete"
