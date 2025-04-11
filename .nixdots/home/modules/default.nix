{ config, inputs, ... }:

{
  imports = [
    ./terminal
    ./bin
    ./wm

    ./telegram
    ./fuzzel
    ./thunar

    inputs.catppuccin.homeManagerModules.catppuccin
  ];
}
