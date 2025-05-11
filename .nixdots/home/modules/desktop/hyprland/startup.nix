{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "echo $HYPRLAND_INSTANCE_SIGNATURE > /tmp/HyprlandInstanceSignature"

      "ln -s '/tmp/TelegramDesktop' '$HOME/Downloads/Telegram Desktop'"

      "uwsm app -- qshell --daemon"

      "uwsm app -- easyeffects --gapplication-service"
      "uwsm app -- copyq --start-server"
      "uwsm app -- blueman-applet"
      "uwsm app -- nm-applet"

      "uwsm app -- waybar"
      "uwsm app -- mako"

      "uwsm app -- run-task-manager --silent"
      "uwsm app -- run-chatgpt --silent"
      "uwsm app -- run-browser --silent"
      "uwsm app -- run-telegram --silent"
    ];
  };
}
