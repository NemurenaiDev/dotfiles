#!/bin/bash

LOCK_FILE="$HOME/.cache/rclone/bisync/GoogleDrive_..home_yabai_GoogleDrive.lck"

sync_drive() {
    output=$(rclone bisync -v GoogleDrive:/ ~/GoogleDrive 2>&1)
    echo "$output"
    echo "$output" >> "$HOME/.config/hypr/.logs/GoogleDriveSync.log"

    if echo "$output" | grep -qE "ERROR|Failed"; then
        error_line=$(echo "$output" | grep -E "ERROR|Failed";)
        notify-send -u critical "Google Drive Sync" "$error_line"
        sleep 60
    fi
}

shutdown_process() {
    echo "[$(date +"%Y-%m-%d %H:%M:%S")][GoogleDriveSync] Initiating graceful shutdown..."
    while [ -f "$LOCK_FILE" ]; do
    	echo "[$(date +"%Y-%m-%d %H:%M:%S")][GoogleDriveSync] Waiting for synchronization to complete..."
        sleep 1
    done
    echo "[$(date +"%Y-%m-%d %H:%M:%S")][GoogleDriveSync] Google Drive Sync gracefully stopped"
    exit 0
}

trap "shutdown_process" EXIT

while :
do
    sync_drive
    sleep 5
done