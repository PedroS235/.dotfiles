#!/bin/bash

# Define an array with the list of PC names you want to check
names=("arch-tower")

# Capture the current hostname
hostname=$(hostnamectl | grep -oP 'Static hostname: \K.*')

# Loop through the list of names and check if any match the current hostname
found=false
for name in "${names[@]}"; do
    if [[ "$hostname" == "$name" ]]; then
        found=true
        hyprctl keyword input:kb_options = 
        break
    fi
done
