#!/bin/bash

CONFIG_SYMLINK="$HOME/.config/hypr/mako/config"
CONFIG=$(readlink -f "$CONFIG_SYMLINK")


start_mako() {
    mako --config ${CONFIG} &
}
stop_mako() {
    killall mako
}

start_mako
trap "stop_mako" SIGINT SIGTERM

while true; do
    inotifywait -e modify "$CONFIG"
    stop_mako
    start_mako
done
