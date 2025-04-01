{ config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "echo $HYPRLAND_INSTANCE_SIGNATURE > /tmp/HyprlandInstanceSignature"

      "mkdir \"/tmp/Telegram Desktop\" && ln -s \"/tmp/Telegram Desktop\" \"$HOME/Downloads/Telegram Desktop\" && rm -rf \"$HOME/Downloads/Telegram \"Desktop/Telegram Desktop"

      "uwsm app -- easyeffects --gapplication-service"
      "uwsm app -- copyq --start-server"
      "uwsm app -- blueman-applet"
      "uwsm app -- nm-applet"

      "uwsm app -- waybar"
      "uwsm app -- mako"

      "${config.home.homeDirectory}/.config/scripts/wireguard -i"

      "${config.home.homeDirectory}/.config/scripts/run/task-manager --silent"
      "${config.home.homeDirectory}/.config/scripts/run/chatgpt --silent"
      "${config.home.homeDirectory}/.config/scripts/run/browser --silent"
      "${config.home.homeDirectory}/.config/scripts/run/telegram --silent"
    ];
  };
}
