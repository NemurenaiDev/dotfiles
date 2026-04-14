{ config, ... }:

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
      ", preferred@auto, 0x0, 1"
      "${monitors.central}, 2560x1600@60, 0x0, 1.6"
    ];

    exec-once = [
      "uwsm app -- ${config.xdg.dataHome}/bin/battery-notifier 20 /sys/class/power_supply/BATT"
    ];
  };
}
