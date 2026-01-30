{ host, ... }:

let
  monitors = {
    central = "eDP-1";
    left = "HDMI-A-1";
  };
in
{
  _module.args.monitors = monitors;

  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", highres@highrr, 0x0, 1"
      "${monitors.central}, 2560x1600@60, 0x0, 1.6"
      "${monitors.left}, 1920x1080@144, -1920x0, 1"
    ];

    exec-once = [
      "uwsm app -- /home/${host.username}/.bin/battery-notifier 20 /sys/class/power_supply/BATT"
    ];
  };
}
