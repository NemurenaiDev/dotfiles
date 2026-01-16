{ wallpaper, ... }:

{
  services.hyprpaper.enable = true;

  home.file.".config/hypr/hyprpaper.conf".force = true;
  home.file.".config/hypr/hyprpaper.conf".text = ''
    ipc = true
    splash = false

    wallpaper {
        monitor = 
        path = ${wallpaper}
    }
  '';
}
