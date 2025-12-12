# { pkgs, ... }:

{
  imports = [ ./bin.nix ];

  home.file.".bin" = {
    force = true;
    recursive = true;
    executable = true;
    source = ./src;
  };

  # home.packages = builtins.map (name: pkgs.writeScriptBin name (builtins.readFile ./src/${name})) (
  #   builtins.attrNames (builtins.readDir ./src)
  # );
}
