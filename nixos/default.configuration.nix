{
  hasRole,
  config,
  inputs,
  host,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = false;
    }

    ./modules/keyd.nix
    ./modules/audio.nix
    ./modules/secrets.nix
    ./modules/packages.nix
    ./modules/plymouth.nix
    ./modules/snapcast.nix
    ./modules/syncthing.nix
  ]
  ++ lib.optionals (hasRole "desktop") [ ./modules/gaming.nix ];

  nixpkgs.hostPlatform = lib.mkDefault host.system;
  system.stateVersion = host.stateVersion;
  networking.hostName = host.hostname;
  time.timeZone = host.timezone;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  users.users.${host.username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "docker"
      "networkmanager"
    ];
  };

  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
  boot.kernelParams = [ "preempt=full" ];
  boot.tmp.cleanOnBoot = true;

  virtualisation.docker.enable = true;

  security.polkit.enable = lib.mkForce (hasRole "desktop");
  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/veracrypt --text --unmount";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  services.journald.extraConfig = "MaxRetentionSec=7day";
  services.libinput.enable = true;
  services.openssh.enable = true;

  services.getty.autologinOnce = hasRole "desktop";
  services.getty.autologinUser = host.username;
  services.getty.greetingLine = lib.mkForce "";
  services.getty.helpLine = lib.mkForce "";

  services.mullvad-vpn.enable = true;
  services.tailscale.enable = true;
  services.resolved = {
    enable = true;
    extraConfig = ''
      DNS=94.140.14.14 94.140.15.15
      FallbackDNS=
      Domains=~.
    '';
  };

  programs.zsh.enable = true;

  programs.hyprland.enable = hasRole "desktop";
  programs.hyprland.withUWSM = hasRole "desktop";

  networking.networkmanager.enable = true;
  networking.networkmanager.settings.WiFi.powerSave = false;

  networking.firewall.allowedTCPPorts = [
    8523 # automation-server
    25565 # minecraft
    57621 # spotify
    57622 # spotify
    57631 # librespot
    57632 # librespot
  ];
  networking.firewall.allowedUDPPorts = [
    5353 # mDNS
    57621 # spotify
    57622 # spotify
    57631 # librespot
    57632 # librespot
  ];

  systemd.tmpfiles.rules = [
    "d /tmp/${host.username}/TelegramDownloads 1700 ${host.username} users -"
  ];
}
