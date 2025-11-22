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
      nodejs
      corepack
      typescript
      inputs.nixpkgs-stable.legacyPackages.${system}.turbo

      neovim
      moor
      highlight
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
      fd
      ripgrep

      inputs.nixpkgs-stable.legacyPackages.${system}.pamixer
      snapcast
      playerctl
      pulseaudio
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
        hypridle
        hyprpaper
        hyprsunset
        hyprpicker
        hyprpolkitagent

        inputs.nixpkgs-stable.legacyPackages.${system}.copyq
        wl-clipboard

        vscode
        unityhub
        dotnet-sdk

        libreoffice
        kitty
        motrix
        obs-studio
        spotify
        telegram-desktop
        vesktop

        nemo-with-extensions
        nemo-fileroller
        file-roller
        kdiskmark
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
    font-awesome

    liberation_ttf

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
