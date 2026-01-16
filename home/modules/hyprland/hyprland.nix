{ monitors, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      general = {
        "gaps_in" = 2.5;
        "gaps_out" = 5;
        "border_size" = 1;
        "resize_on_border" = false;
        "allow_tearing" = true;

        "col.active_border" = "rgb(94E2D5) rgb(F38BA8) rgb(F9E2AF) 270deg";

        "bezier" = "linear, 0.0, 0.0, 1.0, 1.0";
        "animation" = "borderangle, 1, 50, linear, loop";
      };

      group = {
        "col.border_active" = "rgb(94E2D5) rgb(F38BA8) rgb(F9E2AF) 270deg";
        "col.border_inactive" = "rgb(94E2D5) rgb(F38BA8) rgb(F9E2AF) 270deg";
        "col.border_locked_active" = "rgb(94E2D5) rgb(F38BA8) rgb(F9E2AF) 270deg";
        "col.border_locked_inactive" = "rgb(94E2D5) rgb(F38BA8) rgb(F9E2AF) 270deg";

        groupbar = {
          render_titles = false;
          scrolling = false;

          "col.active" = "rgb(94E2D5)";
          "col.inactive" = "rgb(585B70)";
          "col.locked_active" = "rgb(B4BEFE)";
          "col.locked_inactive" = "rgb(45475A)";
        };
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
          "disable_while_typing" = true;
          "natural_scroll" = true;
          "scroll_factor" = 0.25;
          "middle_button_emulation" = true;
          "clickfinger_behavior" = true;
          "tap-to-click" = true;
          "tap-and-drag" = true;
          "drag_lock" = 1;
        };
      };

      gesture = [
        "3, horizontal, workspace"
      ];

      cursor = {
        "sync_gsettings_theme" = true;
        "default_monitor" = monitors.central;
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
        "on_focus_under_fullscreen" = 2;
      };

      ecosystem = {
        "no_update_news" = true;
        "no_donation_nag" = true;
      };

      binds = {
        "workspace_back_and_forth" = false;
      };

      dwindle = {
        "pseudotile" = true;
        "smart_split" = false;
        "preserve_split" = true;
      };

      debug = {
        "full_cm_proto" = true;
      };
    };
  };
}
