{ config, lib, ... }:

let
  monitors = {
    primary = "eDP-1";
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
          (lib.generators.mkLuaInline ''{ output = "${monitors.primary}", mode = "2560x1600@60", position = "0x0", scale = "1.6" }'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''{ output = "${monitors.secondary}", mode = "1920x1080@144", position = "auto-up", scale = "1" }'')
        ];
      }
    ];

    on = {
      _args = [
        "hyprland.start"
        (lib.generators.mkLuaInline ''
          function() 
            hl.exec_cmd("uwsm app -t service -u app-battery-notifier.service -p Restart=always -- ${config.xdg.dataHome}/bin/battery-notifier 20 /sys/class/power_supply/BATT") 
          end
        '')
      ];
    };
  };
}
