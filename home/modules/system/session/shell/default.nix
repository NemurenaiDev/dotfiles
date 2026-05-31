{
  monitors,
  hasRole,
  config,
  pkgs,
  host,
  ...
}:

let
  cloudflare-warp-wayle-module-state = pkgs.writeShellScriptBin "cloudflare-warp-wayle-module-state" ''
    STATE_FILE="/tmp/${host.username}-cwwm-state"
    STATUS="$(${pkgs.cloudflare-warp}/bin/warp-cli --json status | jq -r .status)"

    [[ -f "$STATE_FILE" && "$(cat "$STATE_FILE")" == "$STATUS" ]] || printf '%s' "$STATUS" > "$STATE_FILE"

    IP_RES="$(${pkgs.bkt}/bin/bkt --ttl 15m --modtime "$STATE_FILE" -- curl -fs "https://api.myip.com/")"

    jq -cn \
    	--arg status "$STATUS" \
    	--arg tooltip1 "$(${pkgs.cloudflare-warp}/bin/warp-cli status)" \
    	--arg tooltip2 "$(echo "$IP_RES" | jq -r '"IP: \(.ip)\nCountry: \(.country)"')" \
    	'{alt:$status,tooltip:($tooltip1+"\n\n"+$tooltip2)}'
  '';

  cloudflare-warp-wayle-module-toggle = pkgs.writeShellScriptBin "cloudflare-warp-wayle-module-toggle" ''
    ${pkgs.cloudflare-warp}/bin/warp-cli --json status | \
      ${pkgs.jq}/bin/jq -r .status | \
      ${pkgs.ripgrep}/bin/rg -iq '^(connected|connecting)$' && \
      ${pkgs.cloudflare-warp}/bin/warp-cli disconnect || \
      ${pkgs.cloudflare-warp}/bin/warp-cli connect
  '';
in
{
  services.wayle = {
    enable = true;

    settings = {
      general = {
        font-sans = "JetBrainsMono Nerd Font Mono";
        font-mono = "JetBrainsMono Nerd Font Mono";
      };

      bar = {
        inset-edge = 0.25;
        padding = 0.25;
        module-gap = 0.30;
        bg = "transparent";
        button-variant = "basic";
        button-bg-opacity = 75;
        button-icon-size = 0.60;
        button-label-size = 0.95;
        button-rounding = "full";
        button-gap = 0.75;

        layout = [
          {
            monitor = "*";
            show = true;

            left = builtins.filter (x: x != null) [
              "notifications"
              "dashboard"
              "clock"
              (if hasRole "laptop" then "battery" else null)
              "custom-media"
            ];

            center = builtins.filter (x: x != null) [
              "separator"
              "hyprland-workspaces"
              "separator"
            ];

            right = builtins.filter (x: x != null) [
              "systray"
              "bluetooth"
              "custom-cloudflare-warp"
              "network"
              (if hasRole "laptop" then "brightness" else null)
              "volume"
              "keyboard-input"
            ];
          }
        ];
      };

      styling = {
        scale = 1.0;
        rounding = "lg";

        palette = {
          bg = "#11111b";
          surface = "#181825";
          elevated = "#1e1e2e";
          fg = "#cdd6f4";
          fg-muted = "#bac2de";
          primary = "#b4befe";
          red = "#f38ba8";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          blue = "#74c7ec";
        };
      };

      modules = {
        custom = [
          {
            id = "cloudflare-warp";
            format = "";
            icon-map = {
              "Disconnected" = "tb-cloud-pause-symbolic";
              "Connecting" = "tb-cloud-search-symbolic";
              "Connected" = "tb-cloud-symbolic";
              "Unable" = "tb-cloud-x-symbolic";
            };
            interval-ms = 1000;
            label-show = false;
            left-click = "${cloudflare-warp-wayle-module-toggle}/bin/cloudflare-warp-wayle-module-toggle";
            command = "${cloudflare-warp-wayle-module-state}/bin/cloudflare-warp-wayle-module-state";
          }

          {
            id = "media";
            command = "playerctl -s metadata --format '{\"text\":\"{{artist}} - {{markup_escape(title)}}\",\"alt\":\"{{status}}\"}'";
            left-click = "playerctl play-pause";
            right-click = "dropdown:media";
            middle-click = "playerctl stop";
            interval-ms = 1000;
            hide-if-empty = true;
            label-max-length = 32;
            icon-map = {
              "Playing" = "tb-player-play-symbolic";
              "Paused" = "tb-player-pause-symbolic";
              "Stopped" = "tb-player-stop-symbolic";
            };
          }
        ];

        battery = {
          thresholds = [
            {
              below = 50;
              icon-color = "status-warning";
            }
            {
              below = 20;
              icon-color = "status-error";
              label-color = "status-error";
            }
          ];
        };

        clock = {
          format = "%a %d.%m | %H:%M:%S";
          icon-show = false;
          label-color = "blue";
          dropdown-show-seconds = true;
        };

        hyprland-workspaces = {
          show-special = false;
          urgent-show = false;
          display-mode = "icon";
          icon-size = 0.75;
          label-size = 0.75;
          workspace-padding = 0.20;

          active-color = "fg-muted";
          occupied-color = "fg-muted";
          container-background = "bg-overlay";

          workspace-map = {
            "21" = {
              icon = "tb-brand-vivaldi-symbolic";
            };

            "22" = {
              icon = "tb-spy-symbolic";
            };

            "25" = {
              icon = "tb-brand-telegram-symbolic";
            };

            "36" = {
              icon = "tb-brand-spotify-symbolic";
            };

            "39" = {
              icon = "tb-video-symbolic";
            };
          };
        };

        keyboard-input = {
          icon-show = false;
          layout-alias-map = {
            "English (US)" = "[EN]";
            "Ukrainian" = "[UK]";
            "Russian" = "[RU]";
          };
        };

        media = {
          left-click = "${pkgs.playerctl}/bin/playerctl play-pause";
          right-click = "dropdown:media";
          middle-click = "${pkgs.playerctl}/bin/playerctl stop";
        };

        brightness = {
          scroll-up = "${config.xdg.dataHome}/bin/brightness --inc";
          scroll-down = "${config.xdg.dataHome}/bin/brightness --dec";
        };

        volume = {
          scroll-up = "${config.xdg.dataHome}/bin/volume --inc";
          scroll-down = "${config.xdg.dataHome}/bin/volume --dec";
        };

        bluetooth = {
          label-show = false;
          right-click = "blueman-manager";
        };

        network = {
          label-show = false;
          right-click = "nm-connection-editor";
        };

        notification = {
          popup-monitor = monitors.central;
          popup-duration = 8000;
          popup-position = "bottom-right";
        };

        osd = {
          popup-monitor = monitors.central;
        };

        systray = {
          icon-scale = 0.75;
          blacklist = [
            "*nm*"
            "*blueman*"
            "*openrgb*"
            "*spotify*"
          ];
        };
      };

      osd = {
        margin = 50.0;
      };
    };
  };
}
