{
  imports = [ ./bin ./hyprland ./waybar ./mako ];

  home.file.".config/scripts" = {
    recursive = true;
    executable = true;
    source = ./bin/src;
  };
}
