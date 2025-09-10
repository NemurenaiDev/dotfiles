{
  hasRole,
  config,
  host,
  pkgs,
  ...
}:

let
  sessionVariables = {
    NH_FLAKE = "/home/${host.username}/Projects/dotfiles";

    SHELL = "${pkgs.zsh}/bin/zsh";
    VISUAL = "${pkgs.nano}/bin/nano";
    EDITOR = "${pkgs.nano}/bin/nano";

    PAGER = "${pkgs.moar}/bin/moar";
    SYSTEMD_PAGER = "${pkgs.moar}/bin/moar";
    SYSTEMD_PAGERSECURE = "0";

    PATH = "$PATH:${config.home.homeDirectory}/.yarn/bin";
    NODE_PATH = "${config.home.homeDirectory}/.npm-packages/lib/node_modules";
    SOPS_AGE_KEY_FILE = "/home/${host.username}/.config/sops/age/key.txt";

    HYPRCURSOR_THEME = "catppuccin-mocha-light-cursors";
    HYPRCURSOR_SIZE = 24;
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
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
  home.packages = [ pkgs.catppuccin-cursors.mochaLight ];

  _module.args.wallpaper = "${config.home.homeDirectory}/.assets/wallpapers/dandadan-op1-8-darken.jpg";

  catppuccin = {
    enable = hasRole "desktop";
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
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
