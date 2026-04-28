{ hasRole, pkgs, ... }:

{
  environment.systemPackages =
    with pkgs;
    [
      wine-wayland
      winetricks
      mangohud

      lutris
      bottles
    ]
    ++ lib.optionals (hasRole "gameclient") [
      moonlight-qt
    ];

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  programs.steam = {
    enable = true;
    extest.enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;

    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  services.sunshine = {
    enable = hasRole "gamehost";
    autoStart = hasRole "gamehost";
    openFirewall = hasRole "gamehost";

    settings = {
      system_tray = false;
      output_name = "1";
    };

    applications = {
      apps = [
        {
          name = "Steam";
          image-path = "steam.png";
          exclude-global-prep-cmd = "false";
          prep-cmd = [
            {
              do = "hyprctl dispatch focusmonitor 1";
              undo = "";
            }
            {
              do = "";
              undo = "setsid steam steam://close/bigpicture";
            }
          ];
          detached = [ "setsid steam steam://open/bigpicture" ];
        }
      ];
    };
  };

  # Just in case for Proton
  zramSwap = {
    enable = true;
    memoryPercent = 5;
    priority = 100;
    algorithm = "zstd";
  };
}
