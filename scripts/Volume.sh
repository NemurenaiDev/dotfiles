#!/bin/bash

iDIR="$HOME/.config/hypr/icons"

get_volume() {
	volume=$(pamixer --get-volume)
	echo "$volume"
}
inc_volume() {
	pamixer --allow-boost -i 5
	notify-send -h string:x-canonical-private-synchronous:sys-notify -h int:value:$(get_volume) -c adjustments.volume -i "$iDIR/volume.png" "$(get_volume)%"
}
dec_volume() {
	pamixer --allow-boost -d 5
	notify-send -h string:x-canonical-private-synchronous:sys-notify -h int:value:$(get_volume) -c adjustments.volume -i "$iDIR/volume.png" "$(get_volume)%"
}
toggle_mute() {
	if [ "$(pamixer --get-mute)" == "false" ]; then
		pamixer -m && notify-send -h string:x-canonical-private-synchronous:sys-notify -h int:value:$(get_volume) -c adjustments.volume -i "$iDIR/volume-mute.png" "OFF"
	elif [ "$(pamixer --get-mute)" == "true" ]; then
		pamixer -u && notify-send -h string:x-canonical-private-synchronous:sys-notify -h int:value:$(get_volume) -c adjustments.volume -i "$iDIR/volume.png" "ON"
	fi
}


toggle_mic() {
	if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
		pamixer --default-source -m && notify-send -h string:x-canonical-private-synchronous:sys-notify -h int:value:$(pamixer --default-source --get-volume) -c adjustments.microphone -i "$iDIR/microphone.png" "OFF"
	elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
		pamixer -u --default-source u && notify-send -h string:x-canonical-private-synchronous:sys-notify -h int:value:$(pamixer --default-source --get-volume) -c adjustments.microphone -i "$iDIR/microphone.png" "ON"
	fi
}
inc_mic_volume() {
	pamixer --default-source -i 5
	notify-send -h string:x-canonical-private-synchronous:sys-notify -h int:value:$(pamixer --default-source --get-volume) -c adjustments.microphone -i "$iDIR/microphone.png" "$(pamixer --default-source --get-volume)%"
}
dec_mic_volume() {
	pamixer --default-source -d 5
	notify-send -h string:x-canonical-private-synchronous:sys-notify -h int:value:$(pamixer --default-source --get-volume) -c adjustments.microphone -i "$iDIR/microphone.png" "$(pamixer --default-source --get-volume)%"
}

if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
	toggle_mic
elif [[ "$1" == "--get-icon" ]]; then
	get_icon
elif [[ "$1" == "--get-mic-icon" ]]; then
	get_mic_icon
elif [[ "$1" == "--mic-inc" ]]; then
	inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
	dec_mic_volume
else
	get_volume
fi
