{
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

    ./modules/audio.nix
    ./modules/gaming.nix
    ./modules/secrets.nix
    ./modules/packages.nix
    ./modules/plymouth.nix
  ];

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
      "networkmanager"
    ];
  };

  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
  boot.kernelParams = [ "preempt=full" ];
  boot.tmp.cleanOnBoot = true;

  services.libinput.enable = true;
  services.openssh.enable = true;
  services.locate.enable = true;

  services.getty.autologinOnce = true;
  services.getty.autologinUser = host.username;

  services.mullvad-vpn.enable = true;
  services.resolved = {
    enable = true;
    extraConfig = ''
      DNS=94.140.14.14 94.140.15.15
      FallbackDNS=
      Domains=~.
    '';
  };

  networking.networkmanager.enable = true;
  networking.networkmanager.settings.WiFi.powerSave = false;

  # spotify + automation-server (8523)
  networking.firewall.allowedTCPPorts = [
    57621
    8523
  ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  systemd.tmpfiles.rules = [ "d /tmp/TelegramDownloads 1700 ${host.username} users -" ];

  qt = {
    enable = true;
    style = "kvantum";
    platformTheme = "qt5ct";
  };
}
