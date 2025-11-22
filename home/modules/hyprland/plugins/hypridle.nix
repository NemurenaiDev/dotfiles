{ pkgs, ... }:

{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        unlock_cmd = "";

        on_lock_cmd = "";
        on_unlock_cmd = "";

        before_sleep_cmd = "${pkgs.hyprlock}/bin/hyprlock --immediate --immediate-render --no-fade-in";
        after_sleep_cmd = "";

        inhibit_sleep = 3;
      };
    };
  };
}
