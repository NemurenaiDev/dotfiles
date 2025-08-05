{
  imports = [
    ./bin.nix
    ./run.nix
  ];

  home.file.".bin" = {
    force = true;
    recursive = true;
    executable = true;
    source = ./src;
  };
}
