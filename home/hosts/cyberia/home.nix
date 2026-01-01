let
  monitors = {
    central = "DP-1";
    left = "HDMI-A-1";
  };
in
{
  imports = [ ./../../default.home.nix ];

  _module.args.monitors = monitors;

  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", highres@highrr, 0x0, 1"
      "${monitors.central}, 1920x1080@144, 0x0, 1"
      "${monitors.left}, 1920x1080@144, -1920x0, 1"
      # "${monitors.left}, 1920x1080@144, 0x0, 1, mirror, DP-1"
    ];

    exec-once = [
      "openrgb --startminimized --profile default"
    ];
  };
}
