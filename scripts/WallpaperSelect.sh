#!/bin/bash

# WALLPAPERS PATH
WALLPAPERS_DIR=$HOME/Pictures/wallpapers

# Transition config (type swww img --help for more settings
FPS=60
TYPE="simple"
DURATION=3

# wofi window config (in %)
WIDTH=20
HEIGHT=40

SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# PICS=($(ls ${WALLPAPERS_DIR} | grep -e ".jpg$" -e ".jpeg$" -e ".png$" -e ".gif$"))
# PICS=($(find ${WALLPAPERS_DIR} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \)))
# PICS=($(ls ${WALLPAPERS_DIR} | grep -e ".jpg$" -e ".jpeg$" -e ".png$" -e ".gif$"))
PICS=($(find -L "$WALLPAPERS_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))


RANDOM_PIC=${PICS[ $RANDOM % ${#PICS[@]} ]}
RANDOM_PIC_NAME="${#PICS[@]}. random"

# WOFI STYLES
CONFIG="$HOME/.config/hypr/wofi/WofiBig/config"
STYLE="$HOME/.config/hypr/wofi/style.css"
COLORS="$HOME/.config/hypr/wofi/colors"

# to check if swaybg is running
if [[ $(pidof swaybg) ]]; then
  pkill swaybg
fi



set_wallpaper() {
    local wallpaper_path=$1
    swww img "$wallpaper_path" $SWWW_PARAMS
}


## Wofi Command
wofi_command="wofi --show dmenu \
			--prompt choose...
			--conf $CONFIG --style $STYLE --color $COLORS \
			--width=$WIDTH% --height=$HEIGHT% \
			--cache-file=/dev/null \
			--hide-scroll --no-actions \
			--matching=fuzzy"

menu() {
    # Here we are looping through the PICS array that is composed of all images in the $WALLPAPERS_DIR folder
    for i in ${!PICS[@]}; do
        # keeping the .gif to make sure you know it is animated
        if [[ -z $(echo ${PICS[$i]} | grep .gif$) ]]; then
            printf "$i. $(basename "${PICS[$i]}")\n" # n°. <filename.extension>
        else
            printf "$i. ${PICS[$i]}\n"
        fi
    done

    printf "$RANDOM_PIC_NAME"
}

swww query || swww init

main() {
    choice=$(menu | ${wofi_command})

    # no choice case
    if [[ -z $choice ]]; then return; fi

    # random choice case
    if [ "$choice" = "$RANDOM_PIC_NAME" ]; then
        set_wallpaper "${RANDOM_PIC}"
        return
    fi
    
    pic_index=$(echo $choice | cut -d. -f1)
    set_wallpaper "${PICS[$pic_index]}"
}

# Check if wofi is already running
if pidof wofi >/dev/null; then
    killall wofi
    exit 0
else
    main
fi

# Uncomment to launch something if a choice was made 
# if [[ -n "$choice" ]]; then
    # Restart Waybar
# fi