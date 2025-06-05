{ inputs, ... }:

{
  imports = [
    ./.bin
    ./.desktop
    ./terminal

    ./hyprland
    ./waybar
    ./mako

    ./utils
    ./kitty
    ./copyq
    ./fuzzel
    ./thunar

    ./telegram

    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home.file.".assets" = {
    recursive = true;
    executable = true;
    source = ./.assets;
  };
}
