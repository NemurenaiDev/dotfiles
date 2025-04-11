{ config, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    settings = {
      env = [
        "HYPRCURSOR_THEME,${config.home.sessionVariables.CursorTheme}"
        "HYPRCURSOR_SIZE,${
          builtins.toString config.home.sessionVariables.CursorSize
        }"
        "QT_QPA_PLATFORMTHEME,gtk3"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_DRM_NO_ATOMIC,1"
      ];

      monitor = "eDP-1, 2560x1600@60, 0x0, 1.6";

      general = {
        "gaps_in" = 2.5;
        "gaps_out" = 5;
        "border_size" = 0;
        "resize_on_border" = false;
        "allow_tearing" = true;

        "col.active_border" = "rgb(F38BA8) rgb(94E2D5) rgb(F5C2E7) 270deg";

        "bezier" = "linear, 0.0, 0.0, 1.0, 1.0";
        "animation" = "borderangle, 1, 50, linear, loop";
      };

      input = {
        "repeat_rate" = 50;
        "repeat_delay" = 300;
        "numlock_by_default" = false;
        "accel_profile" = "flat";
        "follow_mouse" = 1;
        "sensitivity" = 0;

        "kb_layout" = "us,ua,ru";
        "kb_options" = "fkeys:basic_13-24";

        touchpad = {
          "disable_while_typing" = false;
          "natural_scroll" = true;
          "scroll_factor" = 0.25;
          "clickfinger_behavior" = true;
          "middle_button_emulation" = true;
          "tap-to-click" = true;
          "drag_lock" = true;
        };
      };

      gestures = {
        "workspace_swipe" = true;
        "workspace_swipe_fingers" = 3;
        "workspace_swipe_distance" = 400;
        "workspace_swipe_invert" = true;
        "workspace_swipe_min_speed_to_force" = 30;
        "workspace_swipe_cancel_ratio" = 0.5;
        "workspace_swipe_create_new" = true;
        "workspace_swipe_forever" = true;
      };

      cursor = {
        "sync_gsettings_theme" = true;
        "default_monitor" = "$MonitorCenter";
      };

      decoration = {
        blur = {
          "enabled" = true;
          "size" = 2;
          "passes" = 2;
          "new_optimizations" = true;
          "special" = true;
        };

        "rounding" = 8;

        "active_opacity" = 1.0;
        "inactive_opacity" = 1.0;
        "fullscreen_opacity" = 1.0;

        "dim_inactive" = false;
        "dim_strength" = 0.1;
      };

      animations = {
        "enabled" = true;

        "bezier" = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 2, myBezier"
          "windowsOut, 1, 2, myBezier, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 5, default"
          "workspaces, 1, 5, default"
          "specialWorkspace, 1, 5, myBezier, slidevert"
        ];
      };

      misc = {
        "disable_hyprland_logo" = true;
        "disable_splash_rendering" = true;
        "key_press_enables_dpms" = true;
        "animate_manual_resizes" = true;
        "focus_on_activate" = false;
        "enable_swallow" = true;
        "vfr" = true;
        "new_window_takes_over_fullscreen" = 2;
        "initial_workspace_tracking" = 2;
      };

      ecosystem = {
        "no_update_news" = true;
        "no_donation_nag" = true;
      };

      binds = { "workspace_back_and_forth" = false; };

      dwindle = {
        "pseudotile" = true;
        "preserve_split" = true;
      };
    };
  };
}
