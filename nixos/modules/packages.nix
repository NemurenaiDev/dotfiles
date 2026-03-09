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
      tailscale

      powerstat
      stress-ng
      lm_sensors

      micro
      nano
      neovim
      vim
      vimv
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
      tldr
      lsd
      man-db
      ncdu
      trash-cli

      bun
      biome
      nodejs
      inputs.stable.legacyPackages.${system}.corepack
      typescript
      serve
      prisma
      inputs.stable.legacyPackages.${system}.turbo

      snapcast
      playerctl
      pulseaudio
      alsa-utils
      pulsemixer
      pamixer

      sops
      nvd
      nix-output-monitor
      home-manager
      nixd
      nixfmt
      nh

      openssl
      postgresql
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
      libgphoto2
      libgsf
      libguestfs
      libva
      libva-utils
      libinput
      ffmpeg
      nmap
      proxychains
      rclone
      rsync
      sdbus-cpp
      sox
      traceroute
      wget
      zram-generator
      curl
    ]
    ++ lib.optionals (hasRole "desktop") (
      with pkgs;
      [
        vivaldi
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
        tesseract

        vscode
        opencode
        code-cursor

        mpv
        haruna

        inputs.stable.legacyPackages.${system}.libreoffice
        kitty
        deluge
        obs-studio
        spotify
        telegram-desktop

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
    font-awesome
    nerd-fonts.jetbrains-mono

    liberation_ttf

    inputs.stable.legacyPackages.${system}.noto-fonts
    inputs.stable.legacyPackages.${system}.noto-fonts-cjk-sans
    inputs.stable.legacyPackages.${system}.noto-fonts-color-emoji
  ];
}
