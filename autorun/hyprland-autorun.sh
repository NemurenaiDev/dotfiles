#!/bin/bash

# rclone sync "GoogleDrive:/" "$HOME/GoogleDrive" >> ~/.config/hypr/autorun/hyprland-autorun.log 2>&1 &


telegram-desktop -startintray &
# telegram-desktop -startintray -workdir "/home/silvan/.local/share/TelegramDesktop/tdata-work" &

~/.config/hypr/scripts/WireguardManager.sh -i &


sleep 1 && swww init &
