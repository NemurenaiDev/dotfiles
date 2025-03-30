{ config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      #   "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      #   "dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY"
      #   "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

      #   "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"

      "mkdir \"/tmp/Telegram Desktop\" && ln -s \"/tmp/Telegram Desktop\" \"$HOME/Downloads/Telegram Desktop\" && rm -rf \"$HOME/Downloads/Telegram \"Desktop/Telegram Desktop"

      "fzf --zsh > $Dotfiles/terminal/zsh/init/fzf.zsh"
      "zoxide init --cmd cd zsh > $Dotfiles/terminal/zsh/init/zoxide.zsh"
      "oh-my-posh init zsh --config $Dotfiles/terminal/ohmyposh.toml > $Dotfiles/terminal/zsh/init/ohmyposh.zsh"

      #   "/opt/urserver/urserver-start --no-manager --no-notify"
      "copyq --start-server"
      "easyeffects --gapplication-service"
      "blueman-applet"
      #   "nm-applet"

      "waybar"
      #   "mako"

      #   "$Dotfiles/scripts/automation-server"
      "$Dotfiles/scripts/wireguard -i"

      "$Dotfiles/scripts/run/task-manager --silent"
      "$Dotfiles/scripts/run/chatgpt --silent"
      "$Dotfiles/scripts/run/browser --silent"
      "$Dotfiles/scripts/run/telegram --silent"
    ];
  };
}
