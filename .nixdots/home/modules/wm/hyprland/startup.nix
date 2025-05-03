{ config, ... }:

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

      "${config.home.homeDirectory}/.bin/run/task-manager --silent"
      "${config.home.homeDirectory}/.bin/run/chatgpt --silent"
      "${config.home.homeDirectory}/.bin/run/browser --silent"
      "${config.home.homeDirectory}/.bin/run/telegram --silent"
    ];
  };
}
