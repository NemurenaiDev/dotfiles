#!/bin/bash

DOTFILES_PATH=~/.config/hypr
RETRY_INTERVAL=60
NOTIFICATION_SENT=false

send_notification() {
  if ! notify-send "$@"; then
    hyprctl notify 3 10000 "rgb(ff1ea3)" " $*"
  fi
}

while true; do
  git -C "$DOTFILES_PATH" fetch

  if git -C "$DOTFILES_PATH" diff --quiet HEAD..origin/master; then
    :
  else
    if git -C "$DOTFILES_PATH" pull; then
      send_notification -u low "Dotfiles Auto-Pull" "Dotfiles pulled from the remote repository."
      NOTIFICATION_SENT=false
    else
      send_notification -u critical "Dotfiles Auto-Pull" "An error occurred while pulling Dotfiles from the remote repository."
    fi
  fi

  if [[ -z $(git -C "$DOTFILES_PATH" status --porcelain) ]]; then
    :
  else
    if ! $NOTIFICATION_SENT; then
      send_notification -u low "Dotfiles Local Changes" "Dotfiles changed locally..."
      NOTIFICATION_SENT=true
    fi
  fi

  sleep $RETRY_INTERVAL
done
