{ lib, ... }:

let
  monitors = {
    primary = "DP-1";
    secondary = "HDMI-A-1";
  };
in
{
  _module.args.monitors = monitors;

  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        _args = [
          (lib.generators.mkLuaInline ''{ output = "", mode = "preferred@auto", position = "auto", scale = "1" }'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''{ output = "${monitors.primary}", mode = "1920x1080@144", position = "0x0", scale = "1" }'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''{ output = "${monitors.secondary}", mode = "1920x1080@144", position = "auto-left", scale = "1" }'')
        ];
      }
    ];

    on = {
      _args = [
        "hyprland.start"
        (lib.generators.mkLuaInline ''
          function() 
            hl.exec_cmd("uwsm app -- openrgb --startminimized --profile default") 
          end
        '')
      ];
    };
  };
}
