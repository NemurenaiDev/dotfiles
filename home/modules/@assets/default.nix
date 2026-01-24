{ inputs, ... }:

{
  home.file.".assets/audio".force = true;
  home.file.".assets/audio".source = ./audio;

  home.file.".assets/icons".force = true;
  home.file.".assets/icons".source = ./icons;

  home.file.".assets/wallpapers".force = true;
  home.file.".assets/wallpapers".source = inputs.wallpapers;
}
