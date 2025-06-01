{
  imports = [ ./run.nix ];

  home.file.".bin" = {
    recursive = true;
    executable = true;
    source = ./src;
  };

  home.file.".assets" = {
    recursive = true;
    executable = true;
    source = ./assets;
  };
}
