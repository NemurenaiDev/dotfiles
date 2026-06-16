{
  hasRole,
  host,
  lib,
  ...
}:

{
  services.tailscale.enable = true;
  services.mullvad-vpn.enable = true;

  services.cloudflare-warp.enable = true;

  systemd.user.services.warp-taskbar.enable = false;
  systemd.services.cloudflare-warp.serviceConfig.LogLevelMax = "notice";

  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        DNS = [
          "94.140.14.14"
          "94.140.15.15"
        ];
        FallbackDNS = [ ];
        Domains = [ "~." ];
      };
    };
  };

  networking.networkmanager.enable = true;
  networking.networkmanager.settings.WiFi.powerSave = false;

  networking.firewall.allowedUDPPorts = [
    5353 # mDNS
    57621 # spotify
    57622 # spotify
  ];
  networking.firewall.allowedTCPPorts = [
    25565 # minecraft
    57621 # spotify
    57622 # spotify
  ]
  ++ lib.optionals (host ? snapserver) [ 1704 ]
  ++ lib.optionals (host ? snapserver) [ 1705 ]
  ++ lib.optionals (hasRole "immich") [ 2283 ]
  ++ lib.optionals (hasRole "hassistant") [ 8123 ];
}
