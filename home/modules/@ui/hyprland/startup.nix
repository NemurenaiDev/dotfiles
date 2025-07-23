{ config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "echo $HYPRLAND_INSTANCE_SIGNATURE > /tmp/HyprlandInstanceSignature"
      "ln -sf '/tmp/TelegramDesktop' '$HOME/Downloads/Telegram Desktop'"

      "hyprlock --immediate --immediate-render --no-fade-in"

      "uwsm app -- ${config.home.homeDirectory}/.bin/automation-server"

      # "uwsm app -- easyeffects --gapplication-service"
      "uwsm app -- copyq --start-server"
      "uwsm app -- blueman-applet"
      "uwsm app -- nm-applet"

      "uwsm app -u app-waybar.scope -- waybar"
      "uwsm app -u app-mako.scope -- mako"

      "uwsm app -- run-task-manager --silent"
      "uwsm app -- run-aichat --silent"
      "uwsm app -- run-browser --silent"
      "uwsm app -- run-telegram --silent"
    ];
  };
}
