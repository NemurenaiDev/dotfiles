{
  imports = [
    ./desktop
    ./run.nix
  ];

  home.file.".bin" = {
    recursive = true;
    executable = true;
    source = ./src;
  };
}
