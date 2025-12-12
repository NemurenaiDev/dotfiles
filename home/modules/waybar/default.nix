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
          "clock#n1"
          "clock#n2"
          "battery"
          "custom/playerlabel"
        ];
        "modules-center" = [ "hyprland/workspaces" ];
        "modules-right" = [
          "tray"
          "backlight"
          "pulseaudio"
          "hyprland/language"
        ];
        "cpu" = {
          "interval" = 1;
          "format" = " {icon} {usage}%  ";
          "format-icons" = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
        };
        "battery" = {
          "format" = "󰁹 {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-charging" = " {capacity}%";
          "format-time" = "{H}h {m}m";
          "states" = {
            "warning" = 40;
            "critical" = 20;
          };
          "interval" = 1;
        };
        "backlight" = {
          "format" = "{icon} {percent}%";
          "format-icons" = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          "tooltip" = false;
        };
        "custom/weather" = {
          "format" = "{text}°";
          "tooltip" = true;
          "interval" = 600;
          "exec" = "wttrbar --hide-conditions";
          "return-type" = "json";
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
          "format" = "<span>{icon}{text}</span>";
          "format-icons" = {
            "Playing" = " ";
            "Paused" = " ";
            "Stopped" = " ";
          };
          "return-type" = "json";
          "max-length" = 36;
          "exec" =
            "playerctl -s metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' || echo '{\"text\": \"\", \"alt\": \"None\", \"class\": \"None\"}'";
          "on-click" = "playerctl play-pause";
          "on-click-right" = "playerctl stop";
          "interval" = 1;
          "tooltip" = false;
        };
        "clock#n1" = {
          "interval" = 1;
          "format" = "{:%a %d.%m}";
          "tooltip-format" = "<tt>{calendar}</tt>";
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "none";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='#f9e2af'><b>{}</b></span>";
              "days" = "<span color='#a6adc8'><b>{}</b></span>";
              "weeks" = "<span color='#bac2de'><b>W{}</b></span>";
              "weekdays" = "<span color='#cdd6f4'><b>{}</b></span>";
              "today" = "<span color='#94e2d5'><b><u>{}</u></b></span>";
            };
          };
          "actions" = {
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
        "clock#n2" = {
          "interval" = 1;
          "format" = "{:%H:%M:%S}";
          "tooltip-format" = "{:%H:%M:%S}";
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
