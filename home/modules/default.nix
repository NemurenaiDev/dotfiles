{
  hasRole,
  inputs,
  lib,
  ...
}:

{
  imports =
    [
      "${builtins.toString ./.}/@bin"

      ./shell
      ./utils

      ./spotifyd

      inputs.catppuccin.homeManagerModules.catppuccin
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

  home.file.".assets" = {
    force = true;
    recursive = true;
    executable = true;
    source = "${builtins.toString ./.}/@assets";
  };
}
