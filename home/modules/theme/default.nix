{
  hasRole,
  config,
  pkgs,
  lib,
  ...
}:

{
  home.sessionVariables = {
    HYPRCURSOR_THEME = "catppuccin-mocha-light-cursors";
    HYPRCURSOR_SIZE = 24;

    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  home.packages = lib.optionals (hasRole "desktop") [ pkgs.catppuccin-cursors.mochaLight ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "teal";
  };

  gtk = {
    enable = hasRole "desktop";

    theme = {
      name = "catppuccin-mocha-teal-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "teal" ];
        size = "standard";
      };
    };

    cursorTheme = {
      name = config.home.sessionVariables.HYPRCURSOR_THEME;
      size = config.home.sessionVariables.HYPRCURSOR_SIZE;
      package = pkgs.catppuccin-cursors.mochaLight;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.theme = config.gtk.theme;
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
