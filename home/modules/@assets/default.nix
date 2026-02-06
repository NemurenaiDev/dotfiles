{ inputs, ... }:

{
  xdg.dataFile."assets/audio".force = true;
  xdg.dataFile."assets/audio".source = ./audio;

  xdg.dataFile."assets/icons".force = true;
  xdg.dataFile."assets/icons".source = ./icons;

  xdg.dataFile."assets/wallpapers".force = true;
  xdg.dataFile."assets/wallpapers".source = inputs.wallpapers;
}
