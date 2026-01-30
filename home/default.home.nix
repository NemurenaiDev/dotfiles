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
    NH_FLAKE = "/home/${host.username}/Projects/dotfiles";

    SHELL = "${pkgs.zsh}/bin/zsh";

    EDITOR = "micro";
    VISUAL = if hasRole "desktop" then "code --wait --new-window" else "micro";

    PAGER = "${pkgs.moor}/bin/moor";
    SYSTEMD_PAGER = "${pkgs.moor}/bin/moor";
    SYSTEMD_PAGERSECURE = "0";

    PATH = "$PATH:/home/${host.username}/.yarn/bin";
    NODE_PATH = "/home/${host.username}/.npm-packages/lib/node_modules";
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

    NIXPKGS_ALLOW_UNFREE = "1";
  };
in
{
  imports = [
    ./hosts/${host.hostname}/home.nix

    inputs.catppuccin.homeModules.catppuccin

    "${toString ./modules}/@assets"
    "${toString ./modules}/@bin"

    ./modules/shell
    ./modules/utils
  ]
  ++ lib.optionals (hasRole "desktop") [
    ./modules/hyprland
    ./modules/waybar
    ./modules/mako
    ./modules/xdg

    ./modules/clipboard
    ./modules/terminal
    ./modules/launcher
    ./modules/explorer

    ./modules/telegram
  ];

  home.stateVersion = host.stateVersion;
  home.sessionVariables = sessionVariables;
  home.username = host.username;
  home.homeDirectory = "/home/${host.username}";
  home.packages = [ pkgs.catppuccin-cursors.mochaLight ];

  home.enableNixpkgsReleaseCheck = false; # bullshit (i guess)

  _module.args.wallpaper = "/home/${host.username}/.assets/wallpapers/erinthul-moon-witch.png";

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
