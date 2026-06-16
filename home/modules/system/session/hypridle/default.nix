{ config, pkgs, ... }:

let
  hyprlock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
in
{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "${hyprlock_cmd}";
        unlock_cmd = "";

        on_lock_cmd = "${config.xdg.dataHome}/bin/switch-layout 0";
        on_unlock_cmd = "";

        before_sleep_cmd = "${hyprlock_cmd} --grace 0 --immediate-render --no-fade-in";
        after_sleep_cmd = "";

        inhibit_sleep = 3;
      };

      listener = [
        # {
        #   timeout = 1800;
        #   on-timeout = "hyprctl dispatch dpms off";
        #   on-resume = "hyprctl dispatch dpms on";
        # }
        # {
        #   timeout = 1800;
        #   on-timeout = "loginctl lock-session";
        #   on-resume = "sleep 1 && ${hyprlock_cmd}"; # restore if crashed
        # }
        # {
        #   timeout = 3600;
        #   on-timeout = "systemctl suspend";
        # }
      ];
    };
  };
}
