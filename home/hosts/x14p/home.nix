let
  monitors = {
    central = "eDP-1";
  };
in
{
  imports = [ ./../../default.home.nix ];

  _module.args.monitors = monitors;

  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", highres@highrr, 0x0, 1"
      "${monitors.central}, 2560x1600@60, 0x0, 1.6"
    ];
  };
}
