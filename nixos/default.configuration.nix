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
    ./hosts/${host.hostname}/configuration.nix

    inputs.catppuccin.nixosModules.catppuccin
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }

    ./modules/keyd.nix
    ./modules/audio.nix
    ./modules/snapcast.nix
    ./modules/syncthing.nix
    ./modules/environment.nix
  ]
  ++ lib.optionals (hasRole "desktop") [
    ./modules/plymouth.nix
    ./modules/gaming.nix
  ];

  system.stateVersion = host.stateVersion;
  networking.hostName = host.hostname;
  time.timeZone = host.timezone;

  nixpkgs.hostPlatform = lib.mkDefault host.system;
  nixpkgs.config.allowUnfree = true;

  nix.settings.use-xdg-base-directories = true;
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
      "plugdev"
      "networkmanager"
    ];
  };

  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
  boot.kernelParams = [ "preempt=full" ];
  boot.tmp.cleanOnBoot = true;
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

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

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.playerctld.enable = true;

  programs.zsh.enable = true;

  programs.hyprland.enable = hasRole "desktop";
  programs.hyprland.withUWSM = hasRole "desktop";

  networking.networkmanager.enable = true;
  networking.networkmanager.settings.WiFi.powerSave = false;

  networking.firewall.allowedTCPPorts = [
    8123 # home-assistant
    8523 # automation-server
    25565 # minecraft
    57621 # spotify
    57622 # spotify
    57631 # librespot
    57632 # librespot
  ]
  ++ lib.optionals (hasRole "immich") [
    2283 # immich
  ];
  networking.firewall.allowedUDPPorts = [
    5353 # mDNS
    57621 # spotify
    57622 # spotify
    57631 # librespot
    57632 # librespot
  ];

  systemd.tmpfiles.rules = [
    "d /tmp/${host.username}/ 1700 ${host.username} users -"
  ];
}
