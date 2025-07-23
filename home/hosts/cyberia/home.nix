{ pkgs, ... }:

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
      "mullvad-vpn"
      "openrgb --startminimized --profile default"
    ];
  };

  systemd.user.services.snapclient-127-0-0-1 = {
    Unit = {
      Description = "Snapclient for 127.0.0.1";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.snapcast}/bin/snapclient --host 127.0.0.1";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services.snapclient-192-168-1-111 = {
    Unit = {
      Description = "Snapclient for 192.168.1.111";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.snapcast}/bin/snapclient --host 192.168.1.111";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
