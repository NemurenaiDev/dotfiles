{ pkgs, ... }:

{
  home.file.".assets" = {
    force = true;
    recursive = true;
    executable = true;
    source = pkgs.lib.cleanSourceWith {
      src = ./.;
      filter = path: type: baseNameOf path != "default.nix";
    };
  };
}
