{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
    mangohud
    steam-run
    
    bottles
    winetricks
    wine-wayland

    prismlauncher
  ];

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  programs.steam = {
    enable = true;

    gamescopeSession.enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  # Just in case for Proton
  zramSwap = {
    enable = true;
    memoryPercent = 5;
    priority = 100;
    algorithm = "zstd";
  };
}
