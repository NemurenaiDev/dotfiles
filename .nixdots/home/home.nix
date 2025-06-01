{ host, pkgs, ... }:

let
  sessionVariables = {
    NH_FLAKE = "/home/${host.username}/nixdots";

    HYPRCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    HYPRCURSOR_SIZE = "18";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_DRM_NO_ATOMIC = "1";
    NIXOS_OZONE_WL = "1";
  };
in
{
  home.stateVersion = host.stateVersion;
  home.sessionVariables = sessionVariables;
  home.username = host.username;
  home.homeDirectory = "/home/${host.username}";

  imports = [ ./modules ];

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        bitrate = 320;
        initial_volume = 100;
        volume_normalisation = false;
        device_type = "computer";
        device_name = "${host.username}@${host.hostname}";
      };
    };
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "maroon";
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  #   xdg.configFile = {
  #     "Kvantum/kvantum.kvconfig".text = ''
  #       [General]
  #       theme=catppuccin-mocha-maroon
  #     '';

  #     # "Kvantum/Catppuccin-Mocha-Maroon".source =
  #     #   "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Maroon";
  #   };

}
