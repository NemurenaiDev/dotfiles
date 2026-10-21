{ config, pkgs, ... }:

let
  hyprlock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
  setlang_cmd = "${config.xdg.dataHome}/bin/switch-layout 0";
in
{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "${setlang_cmd}; ${hyprlock_cmd}";
        unlock_cmd = "";

        on_lock_cmd = "${setlang_cmd}";
        on_unlock_cmd = "";

        before_sleep_cmd = "${setlang_cmd}; ${hyprlock_cmd} --grace 0 --immediate-render --no-fade-in";
        after_sleep_cmd = "${setlang_cmd}";

        inhibit_sleep = 3;
      };
    };
  };
}
