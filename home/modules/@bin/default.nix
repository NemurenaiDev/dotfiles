# { pkgs, ... }:

{
  imports = [ ./bin.nix ];

  xdg.dataFile.bin = {
    force = true;
    recursive = true;
    executable = true;
    source = ./src;
  };

  # home.packages = map (name: pkgs.writeScriptBin name (builtins.readFile ./src/${name})) (
  #   builtins.attrNames (builtins.readDir ./src)
  # );
}
