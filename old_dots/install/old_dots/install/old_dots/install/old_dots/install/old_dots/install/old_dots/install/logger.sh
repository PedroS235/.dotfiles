#!/bin/bash
COLOR_GREEN='\033[1;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_RED='\033[0;31m'
COLOR_OFF='\033[0m'


# log_info - Logs an info message to stdout
#
# Usage: log_info arg1
#   - arg1: The message to be logged
function log_info(){
    echo -e "${COLOR_GREEN}INFO - $1 ${COLOR_OFF}"
}

# log_warn - Logs a warning message to stdout
#
# Usage: log_warn arg1
#   - arg1: The message to be logged
function log_warn(){
    echo -e "${COLOR_YELLOW}WARNING - $1 ${COLOR_OFF}"
}

# log_error - Logs an error message to stdout
#
# Usage: log_error arg1
#   - arg1: The message to be logged
function log_error(){
    echo -e "${COLOR_RED}ERROR - $1 ${COLOR_OFF}"
}
