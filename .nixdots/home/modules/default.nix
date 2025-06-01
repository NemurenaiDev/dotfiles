{ inputs, ... }:

{
  imports = [
    ./bin
    ./desktop
    ./terminal

    ./telegram
    ./thunar

    inputs.catppuccin.homeManagerModules.catppuccin
  ];
}
