{
  hasRole,
  pkgs,
  lib,
  ...
}:

{
  systemd.tmpfiles.rules = [
    "d /var/xdg-jail 0774 root users - -"
  ];

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    WLR_DRM_NO_ATOMIC = "1";
    WLR_NO_HARDWARE_CURSORS = "1";

    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";

    NUGET_PACKAGES = "/var/xdg-jail/nuget";
    DOTNET_CLI_HOME = "/var/xdg-jail/dotnet";
    GRADLE_USER_HOME = "/var/xdg-jail/gradle";
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
      typescript
      serve
      turbo

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
        deluge
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

        mako
        waybar
        libnotify
        droidcam
        electron
        ffmpegthumbnailer
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

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
