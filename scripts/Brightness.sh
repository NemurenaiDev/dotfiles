#!/usr/bin/env bash

iDIR="$HOME/.config/hypr/icons"

# Get brightness
get_backlight() {
	echo $(brightnessctl -m | cut -d, -f4)
}

# Get icons
get_icon() {
	current=$(get_backlight | sed 's/%//')
	if   [ "$current" -le "20" ]; then
		icon="$iDIR/brightness-min.png"
	else
		icon="$iDIR/brightness-max.png"
	fi
}

# Notify
notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -h int:value:"$current" -c adjustments.brightness -i "$icon" "$current%"
}

# Change brightness
change_backlight() {
	brightnessctl set "$1" && get_icon && notify_user
}

# Execute accordingly
case "$1" in
	"--get")
		get_backlight
		;;
	"--inc")
		change_backlight "+5%"
		;;
	"--dec")
		change_backlight "5%-"
		;;
	*)
		get_backlight
		;;
esac