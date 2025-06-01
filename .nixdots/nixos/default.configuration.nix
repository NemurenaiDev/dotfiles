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
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = false;
    }

    ./modules/audio.nix
    ./modules/secrets.nix
    ./modules/packages.nix

    ./modules/gaming.nix
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
  nixpkgs.config.allowUnfree = true;

  users.users.${host.username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
  boot.kernelModules = [
    "v4l2loopback"
    "snd-aloop"
  ];
  boot.kernelParams = [ "--quiet" ];
  boot.tmp.cleanOnBoot = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.settings.WiFi.powerSave = false;

  # spotify + automation-server (8523)
  networking.firewall.allowedTCPPorts = [
    57621
    8523
  ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  services.getty.autologinOnce = true;
  services.getty.autologinUser = host.username;

  services.libinput.enable = true;
  services.openssh.enable = true;
  services.locate.enable = true;

  services.mullvad-vpn.enable = true;

  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  qt = {
    enable = true;
    style = "kvantum";
    platformTheme = "qt5ct";
  };

  systemd.tmpfiles.rules = [ "d /tmp/TelegramDownloads 1700 ${host.username} users -" ];
}
