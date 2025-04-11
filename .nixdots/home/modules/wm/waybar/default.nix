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
            "13" = "\uEAF7";
            "15" = "󰭵";
            "21" = "\uDB80\uDEAF";
            "22" = "󰗹";
            "25" = "";
            "26" = "";
            "31" = "\uF472";
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
          "format-bluetooth" = "{icon} \uDB80\uDCAF {volume}%";
          "format-muted" = "\uDB81\uDF5F Mute";
          "format-icons" = {
            "headphone" = "󰋋";
            "hands-free" = "󰋋";
            "headset" = "󰋎";
            "phone" = "";
            "portable" = "";
            "car" = "\uDB80\uDD0B";
            "default" = [
              "\uDB81\uDD7F"
              "\uDB81\uDD80"
              "\uDB81\uDD7E"
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

        # layer = "top";
        # position = "top";
        # mod = "dock";
        # exclusive = true;
        # passtrough = false;
        # gtk-layer-shell = true;
        # height = 0;
        # modules-left = [
        #   "hyprland/workspaces"
        #   "custom/divider"
        #   "custom/weather"
        #   "custom/divider"
        #   "cpu"
        #   "custom/divider"
        #   "memory"
        # ];
        # modules-center = [ "hyprland/window" ];
        # modules-right = [
        #   "tray"
        #   "network"
        #   "custom/divider"
        #   "backlight"
        #   "custom/divider"
        #   "pulseaudio"
        #   "custom/divider"
        #   "battery"
        #   "custom/divider"
        #   "clock"
        # ];
        # "hyprland/window" = {
        #   format = "{}";
        # };
        # "wlr/workspaces" = {
        #   on-scroll-up = "hyprctl dispatch workspace e+1";
        #   on-scroll-down = "hyprctl dispatch workspace e-1";
        #   all-outputs = true;
        #   on-click = "activate";
        # };
        # battery = {
        #   format = "󰁹 {}%";
        # };
        # cpu = {
        #   interval = 10;
        #   format = "󰻠 {}%";
        #   max-length = 10;
        #   on-click = "";
        # };
        # memory = {
        #   interval = 30;
        #   format = "  {}%";
        #   format-alt = " {used =0.1f}G";
        #   max-length = 10;
        # };
        # backlight = {
        #   format = "󰖨 {}";
        # };
        # "custom/weather" = {
        #   tooltip = true;
        #   format = "{}";
        #   restart-interval = 300;
        #   exec = "/home/roastbeefer/.cargo/bin/weather";
        # };
        # tray = {
        #   icon-size = 13;
        #   tooltip = false;
        #   spacing = 10;
        # };
        # network = {
        #   format = "󰖩 {essid}";
        #   format-disconnected = "󰖪 disconnected";
        # };
        # clock = {
        #   format = " { =%I =%M %p   %m/%d} ";
        #   tooltip-format = ''
        #     <big>{ =%Y %B}</big>
        #     <tt><small>{calendar}</small></tt>'';
        # };
        # pulseaudio = {
        #   format = "{icon} {volume}%";
        #   tooltip = false;
        #   format-muted = " Muted";
        #   on-click = "pamixer -t";
        #   on-scroll-up = "pamixer -i 5";
        #   on-scroll-down = "pamixer -d 5";
        #   scroll-step = 5;
        #   format-icons = {
        #     headphone = "";
        #     hands-free = "";
        #     headset = "";
        #     phone = "";
        #     portable = "";
        #     car = "";
        #     default = [
        #       ""
        #       ""
        #       ""
        #     ];
        #   };
        # };
        # "pulseaudio#microphone" = {
        #   format = "{format_source}";
        #   tooltip = false;
        #   format-source = " {volume}%";
        #   format-source-muted = " Muted";
        #   on-click = "pamixer --default-source -t";
        #   on-scroll-up = "pamixer --default-source -i 5";
        #   on-scroll-down = "pamixer --default-source -d 5";
        #   scroll-step = 5;
        # };
        # "custom/divider" = {
        #   format = " | ";
        #   interval = "once";
        #   tooltip = false;
        # };
        # "custom/endright" = {
        #   format = "_";
        #   interval = "once";
        #   tooltip = false;
        # };
      }
    ];
  };
}
