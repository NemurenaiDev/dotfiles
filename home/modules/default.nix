{ inputs, ... }:

{
  imports = [
    ./.bin
    ./.ui

    ./shell

    ./utils

    ./clipboard
    ./terminal
    ./launcher
    ./explorer

    ./telegram

    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home.file.".assets" = {
    recursive = true;
    executable = true;
    source = ./.assets;
  };
}
