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

    inputs.catppuccin.nixosModules.default
    inputs.home-manager.nixosModules.default
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }

    ./modules/keyd.nix
    ./modules/audio.nix
    ./modules/syncthing.nix
    ./modules/networking.nix
    ./modules/environment.nix
  ]
  ++ lib.optionals (hasRole "desktop") [
    ./modules/gaming.nix
  ];

  system.stateVersion = host.stateVersion;
  networking.hostName = host.hostname;
  time.timeZone = host.timezone;

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
    linger = hasRole "server";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "docker"
      "plugdev"
      "libvirtd"
      "networkmanager"
    ];
  };

  boot.initrd.stage1Greeting = "";
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.kernelParams = [ "preempt=full" ];
  boot.tmp.cleanOnBoot = true;
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  security.polkit.enable = true;
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

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  services.journald.extraConfig = "MaxRetentionSec=7day";
  services.libinput.enable = true;
  services.openssh.enable = true;

  services.getty.autologinOnce = hasRole "desktop";
  services.getty.autologinUser = host.username;
  services.getty.greetingLine = lib.mkForce "";
  services.getty.helpLine = lib.mkForce "";

  services.gvfs.enable = true;
  services.upower.enable = true;
  services.udisks2.enable = true;
  services.playerctld.enable = true;

  programs.zsh.enable = true;

  programs.dconf.enable = hasRole "desktop";
  programs.hyprland.enable = hasRole "desktop";
  programs.hyprland.withUWSM = hasRole "desktop";
}
