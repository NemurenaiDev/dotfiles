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

      inputs.catppuccin.homeManagerModules.catppuccin
    ]
    ++ lib.optionals (hasRole "desktop") [
      "${builtins.toString ./.}/@ui"

      ./clipboard
      ./terminal
      ./launcher
      ./explorer

      ./spotify
      ./telegram
    ];

  home.file.".assets" = {
    force = true;
    recursive = true;
    executable = true;
    source = "${builtins.toString ./.}/@assets";
  };
}
