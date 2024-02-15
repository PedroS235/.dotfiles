#!/bin/sh
# Missing the nzxt controller
megasync & # Start MegaSync
bitwarden & # Start Bitwarden
pactl set-default-sink alsa_output.pci-0000_08_00.4.analog-stereo & # Set default audio output
# picom & # Start Picom
