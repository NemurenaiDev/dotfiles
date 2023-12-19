#!/usr/bin/env bash

STATUS_CONNECTED_STR='{"text":"Connected","class":"connected","alt":"connected"}'
STATUS_DISCONNECTED_STR='{"text":"Disconnected","class":"disconnected","alt":"disconnected"}'
STATUS_FILE=~/.config/hypr/scripts/variables/wireguard-manager-status

function status_wireguard() {
  nmcli connection show | grep -q "wireguard  Silvan-PC"
}

function toggle_wireguard() {
  if status_wireguard; then
    nmcli connection down Silvan-PC
  else
    nmcli connection up Silvan-PC
  fi

  # Save the status to the file after toggling
  if status_wireguard; then
    echo $STATUS_CONNECTED_STR > $STATUS_FILE
  else
    echo $STATUS_DISCONNECTED_STR > $STATUS_FILE
  fi
}

case $1 in
  -s | --status)
    if status_wireguard; then
      echo $STATUS_CONNECTED_STR
    else
      echo $STATUS_DISCONNECTED_STR
    fi
    ;;
  -t | --toggle)
    toggle_wireguard
    ;;
  -i | --init)
    # Read the status from the file and restore the connection if needed
    if [ -f "$STATUS_FILE" ]; then
      status=$(cat $STATUS_FILE)
      if [[ $status == $STATUS_CONNECTED_STR ]]; then
        nmcli connection up Silvan-PC
      elif [[ $status == $STATUS_DISCONNECTED_STR ]]; then
        nmcli connection down Silvan-PC
      else
        echo "Invalid status found in the file: $status"
        exit 1
      fi
    else
      echo "Status file not found. Creating a new one."
      touch $STATUS_FILE
      echo $STATUS_DISCONNECTED_STR > $STATUS_FILE
    fi
    ;;
  *)
    echo "Invalid option. Usage: $0 [-s|--status] [-t|--toggle] [-i|--init]"
    exit 1
    ;;
esac
