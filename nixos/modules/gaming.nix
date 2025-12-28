{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wine-wayland
    winetricks
    steam-run
    mangohud

    lutris
    bottles

    prismlauncher
  ];

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    gamescopeSession.enable = true;

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
