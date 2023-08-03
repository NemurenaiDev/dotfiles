#!/bin/bash

WALLPAPERS_DIR=$HOME/Pictures/wallpapers
CURRENT_WALLPAPER=$WALLPAPERS_DIR/current-wallpaper.jpg

FPS=60
TYPE="simple"
DURATION=3

set_wallpaper() {
    local wallpaper_path="$1"

    if [ -f "$wallpaper_path" ]; then
        cp "$wallpaper_path" "$CURRENT_WALLPAPER"
        swww img "$CURRENT_WALLPAPER" --transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION
    else
        echo "File not found: $wallpaper_path"
        exit 1
    fi
}


if [ $# -eq 0 ]; then
    echo "Usage: $0 <wallpaper_file_path>"
    exit 1
fi

set_wallpaper "$1"
