{
  hasRole,
  config,
  inputs,
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

    NH_FLAKE = "${config.home.homeDirectory}/Projects/dotfiles";
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    SOPS_AGE_KEY_FILE = "${config.xdg.configHome}/sops/age/key.txt";

    KODI_DATA = "${config.xdg.dataHome}/kodi";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
    PKG_CACHE_PATH = "${config.xdg.cacheHome}/pkg-cache";

    NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/config/npmrc";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_TMP = "/run/npm/${host.username}";

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

  nix.assumeXdg = true; # not sure i can remove it
  home.preferXdgDirectories = true;

  home.username = host.username;
  home.homeDirectory = "/home/${host.username}";
  home.stateVersion = host.stateVersion;
  home.sessionVariables = sessionVariables;

  _module.args.wallpaper = "${config.xdg.dataHome}/assets/wallpapers/erinthul-moon-witch.png";

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "teal";
  };

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
