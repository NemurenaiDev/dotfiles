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

        before_sleep_cmd = "vc-unmount; ${hyprlock_cmd} --immediate --immediate-render --no-fade-in";
        after_sleep_cmd = "";

        inhibit_sleep = 3;
      };
    };
  };
}
