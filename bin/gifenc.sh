#!/bin/sh
# Script taken from https://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html

# Run this to generate the palette
# ffmpeg -i input.mp4 -vf palettegen palette.png

palette="./palette.png"
filters="fps=24,scale=1080:-1:flags=lanczos"

ffmpeg -v warning -i $1 -vf "$filters,palettegen" -y $palette
ffmpeg -v warning -i $1 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $2
