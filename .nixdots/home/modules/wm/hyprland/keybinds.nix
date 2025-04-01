{ config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "SUPER, mouse:273, resizewindow"
      "SUPER, mouse:272, movewindow"
    ];

    binde = [
      "SUPER SHIFT, left, resizeactive,-50 0"
      "SUPER SHIFT, right, resizeactive,50 0"
      "SUPER SHIFT, up, resizeactive,0 -50"
      "SUPER SHIFT, down, resizeactive,0 50"

      ", xf86KbdBrightnessDown, exec, ${config.home.homeDirectory}/.config/scripts/brightness --dec"
      ", xf86KbdBrightnessUp, exec, ${config.home.homeDirectory}/.config/scripts/brightness --inc"
      ", xf86MonBrightnessDown, exec, ${config.home.homeDirectory}/.config/scripts/brightness --dec"
      ", xf86MonBrightnessUp, exec, ${config.home.homeDirectory}/.config/scripts/brightness --inc"

      ", xf86audioraisevolume, exec, ${config.home.homeDirectory}/.config/scripts/volume --inc"
      ", xf86audiolowervolume, exec, ${config.home.homeDirectory}/.config/scripts/volume --dec"
      ", XF86Calculator, exec, ${config.home.homeDirectory}/.config/scripts/volume --inc"
      ", XF86HomePage, exec, ${config.home.homeDirectory}/.config/scripts/volume --dec"
    ];

    bind = [
      ", xf86audiomute, exec, ${config.home.homeDirectory}/.config/scripts/volume --toggle"
      ", xf86AudioMicMute, exec, ${config.home.homeDirectory}/.config/scripts/volume --toggle-mic"
      ", XF86Mail, exec, ${config.home.homeDirectory}/.config/scripts/volume --toggle-mic"
      ", XF86Tools, exec, ${config.home.homeDirectory}/.config/scripts/volume --toggle-mic"

      ", xf86audioplay, exec, playerctl play-pause"
      ", XF86audiopause, exec, playerctl play-pause"
      ", xf86audionext, exec, playerctl next"
      ", xf86audioprev, exec, playerctl previous"
      ", xf86audiostop, exec, playerctl stop"
      ", XF86Search, exec, playerctl stop"

      "SUPER ALT, F1, exec, wl-copy \"$(hyprctl -j activewindow)\" && notify-send -u low -t 3000 \"Window info copied\""

      ", code:66, exec, makoctl dismiss"

      "SUPER, F11, fullscreen, 2"

      "SUPER SHIFT, F10, exec, ${config.home.homeDirectory}/.config/scripts/notifications --toggle"
      "SUPER SHIFT, F11, exec, hyprctl reload config-only"
      "SUPER SHIFT, F12, exec, killall inotifywait"

      "SUPER SHIFT, L, exec, ${config.home.homeDirectory}/.config/scripts/run/powermenu"
      "SUPER, L, exec, hyprctl switchxkblayout $KEYBOARD 0 && hyprlock"

      "ALT SHIFT, 1, exec, hyprctl switchxkblayout $KEYBOARD 0"
      "ALT SHIFT, 2, exec, hyprctl switchxkblayout $KEYBOARD 1"
      "ALT SHIFT, 3, exec, hyprctl switchxkblayout $KEYBOARD 2"

      "SUPER, V, exec, copyq show"

      ", Print, exec, ${config.home.homeDirectory}/.config/scripts/screenshot --now"
      "SHIFT, Print, exec, ${config.home.homeDirectory}/.config/scripts/screenshot --now"
      "SUPER ALT, S, exec, ${config.home.homeDirectory}/.config/scripts/screenshot --win"
      "SUPER CTRL, S, exec, ${config.home.homeDirectory}/.config/scripts/screenshot --screen"
      "SUPER SHIFT, S, exec, ${config.home.homeDirectory}/.config/scripts/screenshot --area"

      "SUPER SHIFT, C, exec, hyprpicker --autocopy --no-fancy --render-inactive"

      "SUPER, code:49, exec, kitty"

      "SUPER, S, exec, ps -e | grep -q fuzzel && killall fuzzel || fuzzel &"

      "CTRL SHIFT, escape, exec, ${config.home.homeDirectory}/.config/scripts/run/task-manager"

      "SUPER, E, exec, ${config.home.homeDirectory}/.config/scripts/run/explorer --run-anyway"
      "SUPER SHIFT, E, exec, ${config.home.homeDirectory}/.config/scripts/run/explorer --just-run"

      "SUPER, G, exec, kitty --class \"kitty-pulsemixer\" pulsemixer"
      "SUPER SHIFT, G, exec, pavucontrol"
      "SUPER CTRL, G, exec, easyeffects"
      "SUPER ALT, G, exec, blueman-manager"

      "SUPER, W, exec, ${config.home.homeDirectory}/.config/scripts/run/browser"
      "SUPER, A, exec, ${config.home.homeDirectory}/.config/scripts/run/browser-incognito"
      "SUPER, X, exec, ${config.home.homeDirectory}/.config/scripts/run/telegram"
      "SUPER, C, exec, ${config.home.homeDirectory}/.config/scripts/run/discord"

      "SUPER, F3, exec, ${config.home.homeDirectory}/.config/scripts/run/spotify"
      "SUPER, F4, exec, ${config.home.homeDirectory}/.config/scripts/run/obs-studio"

      "SUPER, TAB, exec, ${config.home.homeDirectory}/.config/scripts/run/aichat"

      "SUPER, Q, killactive"
      "SUPER SHIFT, Q, exec, kill \"$(hyprctl -j activewindow | jq -r '.pid')\""

      "SUPER, RETURN, togglefloating"
      "SUPER SHIFT, RETURN, pin"
      "SUPER, D, layoutmsg, togglesplit"
      "SUPER, F, fullscreen, 2"

      "SUPER CTRL, left, movewindow, l"
      "SUPER CTRL, right, movewindow, r"
      "SUPER CTRL, up, movewindow, u"
      "SUPER CTRL, down, movewindow, d"

      "SUPER, escape, focusmonitor, +1"
      "SUPER SHIFT, escape, movewindow, mon:+1"
      "SUPER CTRL, escape, movecurrentworkspacetomonitor, +1"

      "SUPER, left, movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER, up, movefocus, u"
      "SUPER, down, movefocus, d"

      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, F1, workspace, 9"
      "SUPER, F2, workspace, 10"
      "SUPER CTRL SHIFT, left, workspace, -1"
      "SUPER CTRL SHIFT, right, workspace, +1"

      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8"
      "SUPER SHIFT, F1, movetoworkspace, 9"
      "SUPER SHIFT, F2, movetoworkspace, 10"
    ];
  };
}
