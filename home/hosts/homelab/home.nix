let
  monitors = {
    central = "DP-1";
  };
in
{
  imports = [ ./../../default.home.nix ];

  _module.args.monitors = monitors;

  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", highres@highrr, 0x0, 1"
      "${monitors.central}, 1920x1080@144, 0x0, 1"
    ];
  };
}
