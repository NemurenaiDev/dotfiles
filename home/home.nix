{
  config,
  host,
  pkgs,
  ...
}:

let
  sessionVariables = {
    NH_FLAKE = "/home/${host.username}/Projects/dotfiles";

    HYPRCURSOR_THEME = "catppuccin-mocha-light-cursors";
    HYPRCURSOR_SIZE = "22";
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
  imports = [ ./modules ];

  home.stateVersion = host.stateVersion;
  home.sessionVariables = sessionVariables;
  home.username = host.username;
  home.homeDirectory = "/home/${host.username}";

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-theme = config.home.sessionVariables.HYPRCURSOR_THEME;
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
}
