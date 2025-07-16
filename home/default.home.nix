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

    SHELL = "zsh";
    VISUAL = "nano";
    EDITOR = "nano";

    PATH = "$PATH:${config.home.homeDirectory}/.yarn/bin";
    NODE_PATH = "${config.home.homeDirectory}/.npm-packages/lib/node_modules";

    HYPRCURSOR_THEME = "catppuccin-mocha-light-cursors";
    HYPRCURSOR_SIZE = 22;
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

  _module.args.wallpaper = "${config.home.homeDirectory}/.assets/wallpaper.jpg";

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "maroon";
    gtk.enable = true;
  };

  dconf.settings =
    if hasRole "desktop" then
      {
        "org/gnome/desktop/interface" = {
          cursor-theme = config.home.sessionVariables.HYPRCURSOR_THEME;
        };
      }
    else
      { };

  gtk =
    if hasRole "desktop" then
      {
        enable = true;
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
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
      }
    else
      { };
}
