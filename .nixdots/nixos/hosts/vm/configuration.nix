{ config, lib, pkgs, ... }:

{
  imports = [ ./../../default.configuration.nix ./hardware.nix ];

  time.timeZone = "Europe/Kyiv";

  networking.hostName = "x14p";

  system.stateVersion = "24.11";
}
