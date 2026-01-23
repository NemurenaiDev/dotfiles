{ wallpaper, pkgs, ... }:

{
  services.hyprpaper.enable = true;

  xdg.configFile."hypr/hyprpaper.conf" = {
    text = ''
      ipc = true
      splash = false

      wallpaper {
        monitor =
        path = ${wallpaper}
      }
    '';

    onChange = ''
      ${pkgs.systemd}/bin/systemctl --user restart hyprpaper.service
    '';
  };
}
