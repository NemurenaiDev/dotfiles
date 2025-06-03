{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
    bottles
    mangohud
  ];

  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;

    gamescopeSession.enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
}
