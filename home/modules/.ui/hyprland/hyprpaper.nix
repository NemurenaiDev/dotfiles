{
  config,
  host,
  lib,
  ...
}:

let
  wallpaper = "${config.home.homeDirectory}/.assets/wallpaper.jpg";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ wallpaper ];
      wallpaper = lib.filter (x: x != null) [
        (if host.monitors ? central then "${host.monitors.central}, ${wallpaper}" else null)
        (if host.monitors ? right then "${host.monitors.right}, ${wallpaper}" else null)
        (if host.monitors ? left then "${host.monitors.left}, ${wallpaper}" else null)
      ];
    };
  };
}
