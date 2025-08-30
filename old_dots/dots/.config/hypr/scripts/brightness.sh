#!/usr/bin/env bash

# Get brightness
get_backlight() {
	LIGHT=$(printf "%.0f\n" $(brightnessctl -d '*::kbd_backlight' i))
	echo "${LIGHT}%"
}

# Increase brightness
inc_backlight() {
	brightnessctl set 10%+
}

# Decrease brightness
dec_backlight() {
	brightnessctl set 10%-
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	brightnessctl -d '*::kbd_backlight' g
elif [[ "$1" == "--inc" ]]; then
	inc_backlight
elif [[ "$1" == "--dec" ]]; then
	dec_backlight
else
	get_backlight
fi

