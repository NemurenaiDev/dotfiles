{
  hasRole,
  inputs,
  config,
  host,
  pkgs,
  lib,
  ...
}:

let
  sessionVariables = {
    EDITOR = "micro";
    VISUAL = if hasRole "desktop" then "code --wait --new-window" else "micro";

    SHELL = "${pkgs.zsh}/bin/zsh";
    PAGER = "${pkgs.moor}/bin/moor";
    SYSTEMD_PAGER = "${pkgs.moor}/bin/moor";
    SYSTEMD_PAGERSECURE = "0";

    HYPRCURSOR_THEME = "catppuccin-mocha-light-cursors";
    HYPRCURSOR_SIZE = 24;

    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_DRM_NO_ATOMIC = "1";
    NIXOS_OZONE_WL = "1";

    NIXPKGS_ALLOW_UNFREE = "1";

    NH_FLAKE = "${config.home.homeDirectory}/Projects/dotfiles";
    SOPS_AGE_KEY_FILE = "${config.xdg.configHome}/sops/age/key.txt";

    KODI_DATA = "${config.xdg.dataHome}/kodi";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    PKG_CACHE_PATH = "${config.xdg.cacheHome}/pkg-cache";

    DOTNET_CLI_HOME = "${config.xdg.dataHome}/dotnet";
    NUGET_PACKAGES = "${config.xdg.cacheHome}/NuGetPackages";

    NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";

    TERMINFO = "${config.xdg.dataHome}/terminfo";
    TERMINFO_DIRS = "${config.xdg.dataHome}/terminfo:/usr/share/terminfo";
  };
in
{
  imports = [
    ./hosts/${host.hostname}/home.nix

    inputs.catppuccin.homeModules.catppuccin

    "${toString ./modules}/@assets"
    "${toString ./modules}/@bin"

    ./modules/xdg
    ./modules/shell
    ./modules/utils
  ]
  ++ lib.optionals (hasRole "desktop") [
    ./modules/hyprland
    ./modules/waybar
    ./modules/mako

    ./modules/clipboard
    ./modules/terminal
    ./modules/launcher
    ./modules/explorer

    ./modules/telegram
  ];

  home.username = host.username;
  home.homeDirectory = "/home/${host.username}";
  home.stateVersion = host.stateVersion;
  home.sessionVariables = sessionVariables;
  home.packages = [ pkgs.catppuccin-cursors.mochaLight ];

  home.enableNixpkgsReleaseCheck = false; # bullshit (i guess)

  _module.args.wallpaper = "${config.xdg.dataHome}/assets/wallpapers/erinthul-moon-witch.png";

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
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
