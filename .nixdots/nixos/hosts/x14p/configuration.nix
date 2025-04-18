{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./../../default.configuration.nix
    ./hardware.nix
    ./power.nix
  ];

  time.timeZone = "Europe/Kyiv";

  networking.hostName = "x14p";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  system.stateVersion = "24.11";
}
