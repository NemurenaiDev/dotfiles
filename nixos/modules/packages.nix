{
  hasRole,
  inputs,
  pkgs,
  lib,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.allowInsecurePredicate =
    if hasRole "desktop" then
      pkg: builtins.elem (lib.getName pkg) [ "beekeeper-studio" ]
    else
      (_: false);

  environment.systemPackages =
    with pkgs;
    [
      mullvad
      tailscale

      powerstat
      stress-ng
      lm_sensors

      neovim

      bun
      yarn
      biome
      nodejs
      typescript

      zsh
      starship
      zellij
      lsof
      btop
      jq
      bc

      snapcast
      playerctl
      pulseaudio
      avahi
      pamixer
      nssmdns
      alsa-utils

      sops
      nh
      nvd
      nix-output-monitor
      home-manager
      nixd
      nixfmt-rfc-style

      node2nix
      binutils
      python3
      gnumake
      cmake
      gcc

      usbutils
      plocate
      brightnessctl
      aml
      bind
      bluez
      bridge-utils
      cbonsai
      cloc
      cpio
      dmidecode
      docker
      docker-compose
      espeak-ng
      evtest
      fastfetch
      fd
      fuse-overlayfs
      git
      github-cli
      gvfs
      inotify-tools
      iptables
      less
      libfaketime
      libgphoto2
      libgsf
      libguestfs
      libuinputplus
      libva
      libva-utils
      lsd
      man-db
      mpd
      mpv
      nano
      ncdu
      nmap
      php
      postgresql
      proxychains
      rclone
      rsync
      sdbus-cpp
      sox
      traceroute
      trash-cli
      tree
      wget
      zoxide
      zram-generator
      fzf
      curl
    ]
    ++ lib.optionals (hasRole "server") (with pkgs; [ ])
    ++ lib.optionals (hasRole "desktop") (
      with pkgs;
      [
        inputs.zen-browser.packages.${system}.default

        hyprland
        hyprlang
        hyprlock
        hyprpaper
        hyprpicker

        prismlauncher

        chromium

        mullvad-vpn

        pavucontrol

        nemo-with-extensions
        nemo-fileroller
        gnome-disk-utility

        beekeeper-studio
        vscode

        copyq
        wl-clipboard

        gtk-engine-murrine
        libsForQt5.qtstyleplugin-kvantum
        libsForQt5.qt5ct
        qt6Packages.qt6ct
        qt5.full
        qt6.full

        fuzzel
        blueman
        libnotify
        dconf-editor
        droidcam
        electron
        eog
        ffmpegthumbnailer
        file-roller
        freerdp
        seahorse
        gnome-keyring
        gnome-themes-extra
        grim
        slurp
        kitty
        lutris
        mako
        motrix
        mpc
        networkmanagerapplet
        obs-studio
        postman
        qpwgraph
        remmina
        rwpspread
        spotify
        telegram-desktop
        tk
        vesktop
        waybar
        wev
        wttrbar
        zenity
      ]
    );

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    google-fonts
    font-awesome
  ];
}
