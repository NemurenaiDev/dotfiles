{ config, pkgs, ... }:

let
  #   run-on-workspace = pkgs.writeShellScriptBin "run-on-workspace"
  #     "${builtins.readFile ./src/run-on-workspace}";
in {
  #   home.packages = with pkgs; [
  # run-on-workspace
  #   ];
}
