{
  wallpaper,
  monitors,
  lib,
  ...
}:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ wallpaper ];
      wallpaper = lib.filter (x: x != null) [
        (if monitors ? central then "${monitors.central}, ${wallpaper}" else null)
        (if monitors ? right then "${monitors.right}, ${wallpaper}" else null)
        (if monitors ? left then "${monitors.left}, ${wallpaper}" else null)
      ];
    };
  };
}
