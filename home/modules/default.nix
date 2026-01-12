{
  hasRole,
  inputs,
  lib,
  ...
}:

{
  imports = [
    "${toString ./.}/@assets"
    "${toString ./.}/@bin"

    ./shell
    ./utils

    inputs.catppuccin.homeModules.catppuccin
  ]
  ++ lib.optionals (hasRole "desktop") [
    ./hyprland
    ./waybar
    ./mako
    ./xdg

    ./clipboard
    ./terminal
    ./launcher
    ./explorer

    ./telegram
  ];
}
