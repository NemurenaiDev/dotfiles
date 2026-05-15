{
  hasRole,
  config,
  pkgs,
  lib,
  ...
}:

{
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "teal";
  };

  home.sessionVariables.HYPRCURSOR_THEME = "catppuccin-mocha-light-cursors";
  home.sessionVariables.HYPRCURSOR_SIZE = 24;

  home.packages = lib.optionals (hasRole "desktop") [ pkgs.catppuccin-cursors.mochaLight ];

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
