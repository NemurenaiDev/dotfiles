{
  imports = [ ./../../default.home.nix ];

  _module.args.monitors = { };

  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", highres@highrr, 0x0, 1"
    ];
  };
}
