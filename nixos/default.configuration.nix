{
  hasRole,
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

    ./modules/selinux

    ./modules/audio.nix
    ./modules/networking.nix
    ./modules/environment.nix

    ./modules/syncthing.nix
    ./modules/prometeus.nix
  ]
  ++ lib.optionals (hasRole "desktop") [
    ./modules/keyboard.nix

    ./modules/gaming.nix
  ]
  ++ lib.optionals (hasRole "selinux") [
    ./modules/selinux
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
      "render"
      "docker"
      "plugdev"
      "libvirtd"
      "networkmanager"
    ];
  };

  boot.initrd.stage1Greeting = "";
  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
  boot.extraModprobeConfig = ''options v4l2loopback video_nr=0 card_label="DroidCam" exclusive_caps=1'';
  boot.kernelModules = [ "v4l2loopback" ];
  boot.kernelParams = [ "preempt=full" ];
  boot.tmp.cleanOnBoot = true;
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.oci-containers.backend = "docker";

  security.polkit.enable = true;
  security.pam.services.su.enableGnomeKeyring = hasRole "desktop";
  security.pam.services.sudo.enableGnomeKeyring = hasRole "desktop";
  security.pam.services.login.enableGnomeKeyring = hasRole "desktop";
  security.pam.services.hyprlock.enableGnomeKeyring = hasRole "desktop";

  services.getty = lib.mkIf (hasRole "desktop") {
    helpLine = lib.mkForce "";
    greetingLine = lib.mkForce "";
    autologinUser = host.username;
    autologinOnce = true;
  };

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.KbdInteractiveAuthentication = false;

  services.dbus.enable = true;
  services.libinput.enable = true;
  services.gnome.gnome-keyring.enable = hasRole "desktop";
  services.journald.extraConfig = "MaxRetentionSec=7day";

  services.gvfs.enable = true;
  services.upower.enable = true;
  services.fstrim.enable = true;
  services.udisks2.enable = true;
  services.playerctld.enable = true;

  programs.zsh.enable = true;

  programs.dconf.enable = hasRole "desktop";
  programs.hyprlock.enable = hasRole "desktop";
  programs.hyprland.enable = hasRole "desktop";
}
