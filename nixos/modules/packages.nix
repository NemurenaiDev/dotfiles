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
      inputs.nh.packages.${system}.default

      frp
      tailscale

      powerstat
      stress-ng
      lm_sensors

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
      shfmt

      bun
      yarn
      biome
      nodejs
      corepack
      typescript
      turbo
      serve

      snapcast
      playerctl
      pulseaudio
      alsa-utils
      pamixer

      sops
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

      unzip
      psmisc
      bubblewrap
      socat
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
      libinput
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
      keyd
    ]
    ++ lib.optionals (hasRole "desktop") (
      with pkgs;
      [
        inputs.zen-browser.packages.${system}.default

        ungoogled-chromium

        hyprland
        hyprlang
        hyprlock
        hypridle
        hyprpaper
        hyprsunset
        hyprpicker
        hyprpolkitagent

        copyq
        wl-clipboard

        vscode
        code-cursor

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
        networkmanagerapplet
        postman
        qpwgraph
        remmina
        veracrypt
        udiskie

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
