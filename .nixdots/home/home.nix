{ config, pkgs, host, ... }:

let
  sessionVariables = {
    # GTKTheme = "Catppuccin-GTK-Dark";
    IconTheme = "Papirus-Dark";
    CursorTheme = "catppuccin-mocha-dark-cursors";
    CursorSize = 18;

    MonitorPrimary = "eDP-1";
    KEYBOARD = "at-translated-set-2-keyboard";
  };
in
{
  home.stateVersion = "24.11";
  home.sessionVariables = sessionVariables;
  home.username = host.username;
  home.homeDirectory = "/home/${host.username}";

  imports = [ ./modules ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "maroon";
    gtk.enable = true;
    gtk.flavor = "mocha";
    gtk.accent = "maroon";
  };

  gtk = {
    enable = true;
    # theme.name = config.home.sessionVariables.GTKTheme;
    iconTheme.name = config.home.sessionVariables.IconTheme;
    cursorTheme.name = config.home.sessionVariables.CursorTheme;
    cursorTheme.size = config.home.sessionVariables.CursorSize;
  };
}
