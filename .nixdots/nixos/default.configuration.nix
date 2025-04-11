{
  config,
  inputs,
  host,
  pkgs,
  ...
}:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 0;
  boot.kernelModules = [
    "v4l2loopback"
    "snd-aloop"
  ];
  boot.kernelParams = [ "--quiet" ];
  boot.tmp.cleanOnBoot = true;

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
      "networkmanager"
    ];
  };

  networking.networkmanager.enable = true;
  networking.networkmanager.settings.WiFi.powerSave = false;

  #   services.displayManager.ly.enable = true;
  services.getty.autologinOnce = true;
  services.getty.autologinUser = host.username;
  services.libinput.enable = true;
  services.openssh.enable = true;
  services.locate.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  #   programs.uwsm.waylandCompositors = {
  #     hyprland-lydm-uwsm = {
  #       prettyName = "Hyprland (LyDM UWSM)";
  #       comment = "Hyprland compositor managed by UWSM with fix for LyDM";
  #       binPath = "/run/current-system/sw/bin/hyprland-lydm-uwsm";
  #     };
  #   };

  systemd.tmpfiles.rules = [
    "d /tmp/TelegramDownloads 1700 ${host.username} users -"
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    # (pkgs.writeShellScriptBin "hyprland-lydm-uwsm" ''
    #   systemctl --user stop nixos-fake-graphical-session.target
    #   exec /run/current-system/sw/bin/Hyprland "$@"
    # '')

    inputs.zen-browser.packages.${system}.twilight
    # inputs.qshell.packages.${system}.qshell

    home-manager

    papirus-icon-theme
    catppuccin-cursors.mochaDark

    bun
    yarn
    biome
    nodejs_23

    node2nix
    binutils
    python3
    gnumake
    cmake
    gcc

    zsh
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
    lsof
    btop
    dtach
    jq

    prismlauncher

    plocate
    brightnessctl
    libnotify
    nixfmt-rfc-style
    alsa-utils
    aml
    # beekeeper-studio insecure package beekeeper-studio-5.1.5
    bind
    blueman
    bluez
    bridge-utils
    cbonsai
    cliphist
    cloc
    copyq
    cpio
    dconf-editor
    dmidecode
    docker
    docker-compose
    droidcam
    easyeffects
    electron
    eog
    espeak-ng
    evtest
    fastfetch
    fd
    ffmpegthumbnailer
    file-roller
    freerdp
    fuse-overlayfs
    fuzzel
    gamemode
    git
    github-cli
    gnome-keyring
    gnome-themes-extra
    grim
    gtk-engine-murrine
    gvfs
    hyprland
    hyprlang
    hyprlock
    hyprpaper
    hyprpicker
    inotify-tools
    iptables
    kitty
    less
    libfaketime
    libgphoto2
    libgsf
    libguestfs
    libuinputplus
    libva
    libva-utils
    lsd
    lutris
    mako
    man-db
    motrix
    mpc
    mpd
    mpv
    nano
    ncdu
    networkmanagerapplet
    nmap
    obs-studio
    oh-my-posh
    opentabletdriver
    pamixer
    pavucontrol
    php
    playerctl
    postgresql
    postman
    proxychains
    pulsemixer
    qpwgraph
    rclone
    remmina
    rsync
    rwpspread
    sdbus-cpp
    seahorse
    slurp
    sox
    spotify
    telegram-desktop
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.thunar-volman
    tk
    tlp
    tmux
    traceroute
    trash-cli
    tree
    typescript
    vesktop
    waybar
    wev
    wget
    wireguard-tools
    wl-clipboard
    wttrbar
    zenity
    zoxide
    zram-generator
    fzf
    lsd
    zoxide
    copyq
    oh-my-posh
    vscode
    kitty
    fuzzel
    trash-cli
    telegram-desktop

    git
    wget
    curl
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    google-fonts
    font-awesome
  ];
}
