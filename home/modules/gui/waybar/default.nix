{
  config,
  pkgs,
  host,
  ...
}:

let
  cloudflare-warp-waybar-module-state = pkgs.writeShellScriptBin "cloudflare-warp-waybar-module-state" ''
    STATE_FILE="/tmp/${host.username}-cwwm-state"
    STATUS="$(${pkgs.cloudflare-warp}/bin/warp-cli --json status | jq -r .status)"

    [[ -f "$STATE_FILE" && "$(cat "$STATE_FILE")" == "$STATUS" ]] || printf '%s' "$STATUS" > "$STATE_FILE"

    IP_RES="$(${pkgs.bkt}/bin/bkt --ttl 15m --modtime "$STATE_FILE" -- curl -fs "https://api.myip.com/")"

    jq -cn \
    	--arg status "$STATUS" \
    	--arg tooltip1 "$(${pkgs.cloudflare-warp}/bin/warp-cli status)" \
    	--arg tooltip2 "$(echo "$IP_RES" | jq -r '"IP: \(.ip)\nCountry: \(.country)"')" \
    	'{text: ($tooltip1 + "\n\n" + $tooltip2), alt: $status, class: $status}'
  '';

  cloudflare-warp-waybar-module-toggle = pkgs.writeShellScriptBin "cloudflare-warp-waybar-module-toggle" ''
    ${pkgs.cloudflare-warp}/bin/warp-cli --json status | \
      ${pkgs.jq}/bin/jq -r .status | \
      ${pkgs.ripgrep}/bin/rg -iq '^(connected|connecting)$' && \
      ${pkgs.cloudflare-warp}/bin/warp-cli disconnect || \
      ${pkgs.cloudflare-warp}/bin/warp-cli connect
  '';
in
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
          "custom/warp"
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

            "9" = "F1";
            "10" = "F2";

            "21" = "";
            "22" = "󰗹";
            "25" = "";
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
            "${pkgs.playerctl}/bin/playerctl -s metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' || echo '{\"text\": \"\", \"alt\": \"None\", \"class\": \"None\"}'";
          "on-click" = "${pkgs.playerctl}/bin/playerctl play-pause";
          "on-click-right" = "${pkgs.playerctl}/bin/playerctl stop";
          "interval" = 1;
          "tooltip" = false;
        };
        "custom/warp" = {
          "format" = "<span>{icon}</span>";
          "format-icons" = {
            "Unable" = "<span color='#ff0000'></span>";
            "Connected" = "<span color='#f38020'></span>";
            "Connecting" = "<span color='#ffffff'></span>";
            "Disconnected" = "<span color='#808080'></span>";
          };
          "return-type" = "json";
          "exec" = "${cloudflare-warp-waybar-module-state}/bin/cloudflare-warp-waybar-module-state";
          "on-click" = "${cloudflare-warp-waybar-module-toggle}/bin/cloudflare-warp-waybar-module-toggle";
          "interval" = 1;
          "tooltip" = true;
          "tooltip-format" = "<span>{text}</span>";
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
          "on-click" = "${config.xdg.dataHome}/bin/volume --toggle";
          "on-scroll-up" = "${config.xdg.dataHome}/bin/volume --inc";
          "on-scroll-down" = "${config.xdg.dataHome}/bin/volume --dec";
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
