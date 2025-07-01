{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
    bottles
    mangohud
    steam-run
  ];

  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;

    gamescopeSession.enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  zramSwap = {
    enable = true;

    memoryPercent = 10;
    priority = 100;
    algorithm = "zstd";
  };
}
