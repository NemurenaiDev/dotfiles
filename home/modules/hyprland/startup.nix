{ config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "echo $HYPRLAND_INSTANCE_SIGNATURE > /tmp/HYPRLAND_INSTANCE_SIGNATURE"
      "systemctl --user start hyprpolkitagent"

      "hyprlock --immediate --immediate-render --no-fade-in"

      "uwsm app -- ${config.home.homeDirectory}/.bin/automation-server"
      "uwsm app -- ${config.home.homeDirectory}/.bin/dynamic-window-rules"

      "uwsm app -t service -u app-waybar.service -- waybar"
      "uwsm app -t service -u app-mako.service -- mako"

      "uwsm app -- nm-applet"
      "uwsm app -- blueman-applet"
      "uwsm app -- copyq --start-server"

      "uwsm app -- nemo ~/.local/share/nemo"
      "uwsm app -- run-on-workspace 'special:hidden' 'kitty --single-instance sh' --silent"

      "uwsm app -- run-on-workspace 'special:aichat' 'chromium --app=https://chatgpt.com/' --silent"
      "uwsm app -- run-on-workspace '21' 'zen --profile ${config.home.homeDirectory}/.zen/xxxxxxxx.nemurenai' --silent"
      "uwsm app -- run-on-workspace '25' 'Telegram' --silent"
    ];
  };
}
