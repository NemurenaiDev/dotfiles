#!/bin/bash

BUILDSDIR=$HOME/.config/hypr/builds
SCRIPTSDIR=$HOME/.config/hypr/scripts


_ps=(waybar mako)
for _prs in "${_ps[@]}"; do
	if [[ $(pidof ${_prs}) ]]; then
		killall -9 ${_prs}
	fi
done


${SCRIPTSDIR}/startup/Mako.sh &
${SCRIPTSDIR}/startup/Waybar.sh &
${SCRIPTSDIR}/WireguardManager.sh -i &

${BUILDSDIR}/lan-mouse/lan-mouse &


# rclone sync "GoogleDrive:/" "$HOME/GoogleDrive" >> ~/.config/hypr/autorun/hyprland-autorun.log 2>&1 &

telegram-desktop -startintray &
# telegram-desktop -startintray -workdir "/home/silvan/.local/share/TelegramDesktop/tdata-work" &


sleep 1 && swww init &
