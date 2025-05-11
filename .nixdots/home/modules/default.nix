{ config, inputs, ... }:

{
  imports = [
    ./desktop
    ./terminal
    ./bin

    ./telegram
    ./fuzzel
    ./thunar

    inputs.catppuccin.homeManagerModules.catppuccin
  ];
}
