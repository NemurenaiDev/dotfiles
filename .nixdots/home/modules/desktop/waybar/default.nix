{ config, ... }:

{
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
    settings = [
      {
        "ipc" = true;
        "layer" = "top";
        "position" = "top";
        "exclusive" = true;
        "passthrough" = false;
        "fixed-center" = true;
        "spacing" = 0;
        "margin-top" = 5;
        "margin-bottom" = 0;
        "margin-left" = 5;
        "margin-right" = 5;
        "modules-left" = [
          "custom/notification"
          "clock"
          "battery"
          "custom/weather"
        ];
        "modules-center" = [ "hyprland/workspaces" ];
        "modules-right" = [
          "custom/playerlabel"
          "tray"
          "backlight"
          "pulseaudio"
          "hyprland/language"
        ];
        "battery" = {
          "format" = "󰁹 {}%";
        };
        "custom/weather" = {
          "format" = "{}°";
          "tooltip" = true;
          "interval" = 600;
          "exec" = "wttrbar --hide-conditions";
          "return-type" = "json";
        };
        "custom/notification" = {
          "format" = "{icon}";
          "tooltip" = false;
          "interval" = 1;
          "return-type" = "json";
          "format-icons" = {
            "default" = "<span color=\"#F7F7F7\">\uF49A</span>";
            "do-not-disturb" = "<span color=\"#F7F7F7\">\uF478</span>";
          };
          "on-click" = "exec ${config.home.homeDirectory}/.bin/notifications --toggle";
          "exec" = "exec ${config.home.homeDirectory}/.bin/notifications";
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
          "all-outputs" = true;
          "sort-by-number" = true;
          "format-icons" = {
            "default" = "?";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
            "13" = "󰉋";
            "15" = "󰭵";
            "21" = "";
            "22" = "󰗹";
            "25" = "";
            "26" = "";
            "36" = "";
            "39" = "";
          };
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
        };
        "custom/playerlabel" = {
          "format" = "<span>{}</span>";
          "return-type" = "json";
          "max-length" = 36;
          "exec" =
            "playerctl -s metadata --format '{\"text\" = \"{{artist}} - {{markup_escape(title)}}\"; \"alt\" = \"{{status}}\"; \"class\" = \"{{status}}\"}'";
          "interval" = 1;
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          # "format" = "{ =%H =%M =%S %a %d.%m}";
          "tooltip-format" = "<tt>{calendar}</tt>";
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "none";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='#ffead3'><b>{}</b></span>";
              "days" = "<span color='#ecc6d9'><b>{}</b></span>";
              "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
              "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
              "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          "actions" = {
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
        "hyprland/language" = {
          "format" = "{}";
          "format-en" = "[US]";
          "format-uk" = "[UK]";
          "format-ru" = "[RU]";
        };
        "pulseaudio" = {
          "format" = "{icon} {volume}%";
          "format-bluetooth" = "{icon} 󰂯 {volume}%";
          "format-muted" = "󰖁 Mute";
          "format-icons" = {
            "headphone" = "󰋋";
            "hands-free" = "󰋋";
            "headset" = "󰋎";
            "phone" = "";
            "portable" = "";
            "default" = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            "ignored-sinks" = [ "easyeffects_sink" ];
          };
          "ignored-sinks" = [ "Easy Effects Sink" ];
          "scroll-step" = 5.0;
          "on-click" = "${config.home.homeDirectory}/.bin/volume --toggle";
          "on-click-right" = "pavucontrol";
          "on-scroll-up" = "${config.home.homeDirectory}/.bin/volume --inc";
          "on-scroll-down" = "${config.home.homeDirectory}/.bin/volume --dec";
          "smooth-scrolling-threshold" = 1;
          "interval" = 1;
        };
        "tray" = {
          "icon-size" = 16;
          "spacing" = 6;
        };
      }
    ];
  };
}
