{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "echo $HYPRLAND_INSTANCE_SIGNATURE > /tmp/HYPRLAND_INSTANCE_SIGNATURE"

      "systemctl --user start hyprpolkitagent"

      "hyprlock --grace 0 --immediate-render --no-fade-in"

      "uwsm app -- udiskie --automount --notify --smart-tray"

      "uwsm app -- copyq --start-server"
      "uwsm app -- tailscale systray --theme dark:nobg"

      "uwsm app -- run-on-workspace 'special:hidden' 'nemo ~/.local/share/nemo' --silent"
      "uwsm app -- run-on-workspace 'special:hidden' 'kitty --single-instance sh' --silent"

      "uwsm app -- run-on-workspace '25' 'Telegram' --silent"

      "uwsm app -- run-after-keyring run-on-workspace '21' 'vivaldi' --silent"
      "uwsm app -- run-after-keyring run-on-workspace 'special:aichat' 'chromium --app=https://chatgpt.com/' --silent"
    ];
  };
}
