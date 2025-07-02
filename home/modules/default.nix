{ inputs, ... }:

{
  imports = [
    "${builtins.toString ./.}/@bin"
    "${builtins.toString ./.}/@ui"

    ./shell
    ./utils

    ./clipboard
    ./terminal
    ./launcher
    ./explorer

    ./spotify
    ./telegram

    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home.file.".assets" = {
    recursive = true;
    executable = true;
    source = "${builtins.toString ./.}/@assets";
  };
}
