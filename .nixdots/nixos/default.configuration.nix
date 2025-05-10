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
  # spotify
  networking.firewall.allowedTCPPorts = [ 57621 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

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

  qt = {
    enable = true;
    style = "kvantum";
    platformTheme = "qt5ct";
  };

  systemd.tmpfiles.rules = [ "d /tmp/TelegramDownloads 1700 ${host.username} users -" ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${system}.default
    inputs.qshell.packages.${system}.default

    home-manager

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

    papirus-icon-theme
    # catppuccin-papirus-folders
    catppuccin-cursors.mochaDark
    # magnetic-catppuccin-gtk

    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    qt5.full
    qt6.full
    gtk-engine-murrine

    snapcast
    pavucontrol
    playerctl
    pulseaudio
    avahi
    pamixer
    nssmdns

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
    php
    postgresql
    postman
    proxychains
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
