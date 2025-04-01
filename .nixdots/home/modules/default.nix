{ config, inputs, ... }:

{
  imports = [
    ./terminal
    ./telegram
    ./fuzzel
    ./thunar
    ./wm



    inputs.catppuccin.homeManagerModules.catppuccin
  ];
}
