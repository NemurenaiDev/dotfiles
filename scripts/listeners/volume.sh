#get volume: pamixer --get-volume
#check muted: pamixer --get-mute
#get mic volume: pamixer --default-source --get-volume
#check mic muted: pamixer --default-source --get-mute


while true; do
    pactl subscribe | grep "'new' on client" |
	while IFS= read -r line; do
    	echo "Received event: $line"
	done
done