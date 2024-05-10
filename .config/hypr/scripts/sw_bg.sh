#!/bin/bash
SET_BG="$HOME/Pictures/Walpapers/v1-background-dark.jpg"

restart_waybar() {
    #restart the waybar
    pkill waybar
    waybar & 
}

set_current_background() {
    swww img $SET_BG
}

if [[ "$1" == "setbg" ]]; then
    set_current_background
    restart_waybar
fi
