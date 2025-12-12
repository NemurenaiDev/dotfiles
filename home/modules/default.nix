{
  hasRole,
  inputs,
  lib,
  ...
}:

{
  imports = [
    "${builtins.toString ./.}/@assets"
    "${builtins.toString ./.}/@bin"

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
