{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # inputs.nixpkgs-stable.legacyPackages.${host.system}.fuzzel

    inputs.zen-browser.packages.${system}.default
    inputs.qshell.packages.${system}.default

    chromium

    mullvad-vpn

    bun
    yarn
    biome
    nodejs_24

    node2nix
    binutils
    python3
    gnumake
    cmake
    gcc

    zsh
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
    lsof
    btop
    jq

    prismlauncher

    catppuccin-cursors.mochaDark
    # magnetic-catppuccin-gtk

    gtk-engine-murrine
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    qt5.full
    qt6.full

    snapcast
    pavucontrol
    playerctl
    pulseaudio
    avahi
    pamixer
    nssmdns

    nh
    nvd
    nix-output-monitor
    nixd
    nixfmt-rfc-style

    fuzzel
    plocate
    brightnessctl
    libnotify
    alsa-utils
    aml
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
    vscode
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
