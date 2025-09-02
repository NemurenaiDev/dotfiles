{
  hasRole,
  inputs,
  pkgs,
  lib,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    with pkgs;
    [
      frp
      mullvad
      tailscale

      powerstat
      stress-ng
      lm_sensors

      bun
      yarn
      biome
      turbo
      nodejs
      corepack
      typescript

      neovim
      zsh
      chafa
      starship
      zellij
      lsof
      btop
      jq
      bc
      tree
      zoxide
      fzf

      snapcast
      playerctl
      pulseaudio
      pulsemixer
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

      openssl
      php
      postgresql
      node2nix
      binutils
      python3
      gnumake
      cmake
      gcc

      jdk
      wakeonlan
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
      mpv
      ffmpeg
      nano
      ncdu
      nmap
      proxychains
      rclone
      rsync
      sdbus-cpp
      sox
      traceroute
      trash-cli
      wget
      zram-generator
      curl
    ]
    ++ lib.optionals (hasRole "desktop") (
      with pkgs;
      [
        inputs.zen-browser.packages.${system}.default

        chromium

        hyprland
        hyprlang
        hyprlock
        hyprpaper
        hyprpicker
        hyprland

        prismlauncher

        nemo-with-extensions
        nemo-fileroller

        vscode

        copyq
        wl-clipboard

        libreoffice
        mullvad-vpn
        kitty
        motrix
        obs-studio
        spotify
        telegram-desktop
        vesktop
        gnome-disk-utility
        file-roller
        pavucontrol
        fuzzel
        blueman
        dconf-editor
        lutris
        networkmanagerapplet
        postman
        qpwgraph
        remmina

        mako
        waybar
        libnotify
        droidcam
        electron
        ffmpegthumbnailer
        seahorse
        gnome-keyring
        gnome-themes-extra

        mpc
        freerdp
        tk
        wev
        wttrbar

        dipc
        eog
        grim
        slurp
        rwpspread

        gtk-engine-murrine
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
