#!/bin/bash


function kill_process(){
    if ps aux | grep -iq $1 > /dev/null; then
        pkill -x $1
    fi
}


kill_process gjs
kill_process mako
kill_process swww 
swww-daemon 
hyprpanel &
