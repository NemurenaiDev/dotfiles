{ inputs, ... }:

{
  imports = [
    ./wm/hyprland
    ./wm/waybar
    ./wm/mako

    ./terminal
    
    ./telegram
    ./fuzzel
    ./thunar

    inputs.catppuccin.homeManagerModules.catppuccin
  ];
}
