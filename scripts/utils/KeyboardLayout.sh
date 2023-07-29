#!/bin/bash

layouts=("us" "ua" "ru")
groups=("us" "ua,ru")

variables=~/.config/hypr/scripts/variables
keyboard="$1"
command="$2"


init() {
    echo 0 > "$variables/keyboard-layout"
    echo 0 > "$variables/keyboard-layout-group"

    layouts_string=""
    for layout in "${layouts[@]}"; do
        layouts_string+="$layout,"
    done
    layouts_string=${layouts_string%,}
    hyprctl keyword input:kb_layout $layouts_string
}

next() {
    current_layout=$(cat "$variables/keyboard-layout")
    current_group=$(cat "$variables/keyboard-layout-group")

    IFS=',' read -ra current_group_layouts <<< "${groups[$current_group]}"
    layout_index=-1
    for i in "${!current_group_layouts[@]}"; do
        if [ "${current_group_layouts[i]}" = "${layouts[$current_layout]}" ]; then
            layout_index=$i
            break
        fi
    done

    next_layout_index=$(( (layout_index + 1) % ${#current_group_layouts[@]} ))
    next_layout=""
    for i in "${!layouts[@]}"; do
        if [ "${layouts[i]}" = "${current_group_layouts[next_layout_index]}" ]; then
            next_layout=$i
            break
        fi
    done

    hyprctl switchxkblayout $keyboard $next_layout
    echo "$next_layout" > "$variables/keyboard-layout"
}

nextGroup() {
    current_group=$(cat "$variables/keyboard-layout-group")
    next_group=$(( (current_group + 1) % ${#groups[@]} ))

    IFS=',' read -ra next_group_layouts <<< "${groups[$next_group]}"
    next_layout_index=-1
    for i in "${!layouts[@]}"; do
        if [ "${layouts[i]}" = "${next_group_layouts[0]}" ]; then
            next_layout_index=$i
            break
        fi
    done

    hyprctl switchxkblayout $keyboard $next_layout_index
    echo "$next_layout_index" > "$variables/keyboard-layout"
    echo "$next_group" > "$variables/keyboard-layout-group"
}



case $command in
  "init") init ;;
  "next") next ;;
  "next-group") nextGroup ;;
  *) echo "Unknown command." ;;
esac
