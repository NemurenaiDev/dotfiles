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
    NIXOS_OZONE_WL = "1";

    WLR_DRM_NO_ATOMIC = "1";
    WLR_NO_HARDWARE_CURSORS = "1";

    EDITOR = "micro";
    VISUAL = if hasRole "desktop" then "code --wait --new-window" else "micro";

    SHELL = "${pkgs.zsh}/bin/zsh";
    PAGER = "${pkgs.moor}/bin/moor";
    SYSTEMD_PAGER = "${pkgs.moor}/bin/moor";
    SYSTEMD_PAGERSECURE = "0";

    NH_FLAKE = "${config.home.homeDirectory}/Projects/dotfiles";
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";

    KODI_DATA = "${config.xdg.dataHome}/kodi";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
    PKG_CACHE_PATH = "${config.xdg.cacheHome}/pkg-cache";

    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";

    NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/config/npmrc";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";

    TERMINFO = "${config.xdg.dataHome}/terminfo";
    TERMINFO_DIRS = "${config.xdg.dataHome}/terminfo:/usr/share/terminfo";
  };
in
{
  imports = [
    inputs.catppuccin.homeModules.default

    ./hosts/${host.hostname}/home.nix
  ]
  ++ [
    ./bin
    ./assets

    ./modules/cli
    ./modules/theme

    ./modules/system/services
  ]
  ++ lib.optionals (hasRole "desktop") [
    ./modules/gui

    ./modules/system/session
    ./modules/system/xdg-jail.nix
  ];

  xdg.enable = true;
  nix.assumeXdg = true; # not sure i can remove it
  home.preferXdgDirectories = true;

  home.username = host.username;
  home.homeDirectory = "/home/${host.username}";
  home.stateVersion = host.stateVersion;
  home.sessionVariables = sessionVariables;

  _module.args.wallpaper = "${config.xdg.dataHome}/assets/wallpapers/erinthul-moon-witch.png";

  systemd.user.tmpfiles.rules = [ "d /tmp/${host.username}/ 1700 ${host.username} users - -" ];
}
