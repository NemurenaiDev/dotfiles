{ wallpaper, ... }:

{
  catppuccin.hyprlock.enable = false;

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
        no_fade_out = false;
      };

      background = [
        {
          monitor = "";
          path = wallpaper;
          blur_passes = 2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.5)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          font_family = "JetBrainsMono Nerd Font Mono";
          hide_input = false;
          position = "0, 30";
          halign = "center";
          valign = "bottom";
        }
      ];

      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%H:%M:%S")"'';
          color = "$foreground";
          font_size = 120;
          font_family = "JetBrainsMono Nerd Font Mono ExtraBold";
          position = "0, 50";
          halign = "center";
          valign = "center";
        }
      ];
    };

  };
}
