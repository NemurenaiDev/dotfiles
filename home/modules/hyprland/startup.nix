{ config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "echo $HYPRLAND_INSTANCE_SIGNATURE > /tmp/HYPRLAND_INSTANCE_SIGNATURE"
      "systemctl --user start hyprpolkitagent"

      "hyprlock --immediate --immediate-render --no-fade-in"

      "uwsm app -- ${config.home.homeDirectory}/.bin/automation-server"

      "uwsm app -t service -u app-waybar.service -- waybar"
      "uwsm app -t service -u app-mako.service -- mako"

      "uwsm app -- nemo ~/.local/share/nemo"
      "uwsm app -- copyq --start-server"
      "uwsm app -- blueman-applet"
      "uwsm app -- nm-applet"

      "uwsm app -- run-task-manager --silent"
      "uwsm app -- run-aichat --silent"
      "uwsm app -- run-browser --silent"
      "uwsm app -- run-telegram --silent"
    ];
  };
}
