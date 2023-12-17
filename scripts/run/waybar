#!/bin/bash

CONFIG_SYMLINK="$HOME/.config/waybar/config.json"
STYLE_SYMLINK="$HOME/.config/waybar/style.css"

CONFIG=$(readlink -f "$CONFIG_SYMLINK")
STYLE=$(readlink -f "$STYLE_SYMLINK")


start_waybar() {
    waybar --bar main-bar --log-level error --config "${CONFIG}" --style "${STYLE}" &
}
stop_waybar() {
    killall waybar
}

start_waybar
trap "stop_waybar" SIGINT SIGTERM

while true; do
    inotifywait -e modify "$CONFIG" "$STYLE"
    stop_waybar
    start_waybar
done
