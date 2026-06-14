{
  hasRole,
  pkgs,
  lib,
  ...
}:

{
  systemd.tmpfiles.rules = [
    "d /tmp/xdg-jail/ 1774 root users - -"
  ];

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";

    NUGET_PACKAGES = "/tmp/xdg-jail/nuget";
    DOTNET_CLI_HOME = "/tmp/xdg-jail/dotnet";
    GRADLE_USER_HOME = "/tmp/xdg-jail/gradle";
  };

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
      typescript
      serve
      turbo
      pnpm

      snapcast
      playerctl
      pulseaudio
      alsa-utils
      pulsemixer
      pamixer

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
      bluetui
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

        mpv
        haruna

        kitty
        qbittorrent
        obs-studio
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
        qpwgraph
        remmina
        veracrypt
        udiskie
        gnome-disk-utility

        virt-manager
        qemu_full

        libnotify
        droidcam
        electron
        ffmpegthumbnailer
        gnome-themes-extra

        mpc
        freerdp
        tk
        wev

        eog
        satty
        grimblast

        gtk-engine-murrine
      ]
    );

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono

    liberation_ttf

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
