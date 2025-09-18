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
    ];

    bindr = [
      "SHIFT, SHIFT_L, exec, makoctl dismiss"
    ];

    bind = [
      ### other ###

      "SUPER ALT, F1, exec, hyprctl -j activewindow > /tmp/.windowinfo && kitty --single-instance --class kitty-windowinfo sh -c 'cat /tmp/.windowinfo | moar'"

      "SUPER SHIFT, F11, exec, hyprctl reload config-only"
      "SUPER SHIFT, F12, exec, systemctl --user restart app-waybar"

      "SUPER SHIFT, L, exec, run-powermenu"

      "SUPER, L, exec, ${config.home.homeDirectory}/.bin/switch-layout 0 && hyprlock"

      ### utility apps ###

      "SUPER, code:49, exec, kitty --single-instance"

      "SUPER, V, exec, copyq show"

      "SUPER, S, exec, fuzzel"

      "SUPER SHIFT, C, exec, hyprpicker --autocopy --no-fancy --render-inactive"

      ### workspace-specific applications ###

      "CTRL SHIFT, escape, exec, run-task-manager"

      "SUPER SHIFT, E, exec, run-explorer --run-anyway"
      "SUPER, E, exec, run-explorer --just-run"

      "SUPER, W, exec, run-browser"
      "SUPER, A, exec, run-browser-incognito"
      "SUPER, X, exec, run-telegram"
      "SUPER, C, exec, run-discord"

      "SUPER, F3, exec, run-spotify"
      "SUPER, F4, exec, run-obs"

      "SUPER, TAB, exec, run-aichat"

      ### audio & bluetooth ###

      "SUPER, G, exec, run-sink-selector"
      "SUPER SHIFT, G, exec, pavucontrol"
      "SUPER ALT, G, exec, blueman-manager"

      ### screenshot ###

      ", Print, exec, ${config.home.homeDirectory}/.bin/screenshot --now"
      "SHIFT, Print, exec, ${config.home.homeDirectory}/.bin/screenshot --now"
      "SUPER ALT, S, exec, ${config.home.homeDirectory}/.bin/screenshot --win"
      "SUPER CTRL, S, exec, ${config.home.homeDirectory}/.bin/screenshot --screen"
      "SUPER SHIFT, S, exec, ${config.home.homeDirectory}/.bin/screenshot --area"

      ### focus control ###

      "SUPER, escape, focusmonitor, +1"
      "SUPER SHIFT, escape, movewindow, mon:+1"
      "SUPER CTRL, escape, movecurrentworkspacetomonitor, +1"

      "ALT, Tab, cyclenext"

      "SUPER, left, movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER, up, movefocus, u"
      "SUPER, down, movefocus, d"

      ### window control ###

      "SUPER, Q, killactive"
      "SUPER SHIFT, Q, exec, kill \"$(hyprctl -j activewindow | jq -r '.pid')\""

      "SUPER, F, fullscreen, 2"
      "SUPER, F11, fullscreen, 2"

      "SUPER, RETURN, togglefloating"
      "SUPER SHIFT, RETURN, pin"
      "SUPER, D, layoutmsg, togglesplit"

      "SUPER CTRL, left, movewindow, l"
      "SUPER CTRL, right, movewindow, r"
      "SUPER CTRL, up, movewindow, u"
      "SUPER CTRL, down, movewindow, d"

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

      ### workspace control ###

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

      ### keyboard layout ###

      "ALT SHIFT, 1, exec, ${config.home.homeDirectory}/.bin/switch-layout 0"
      "ALT SHIFT, 2, exec, ${config.home.homeDirectory}/.bin/switch-layout 1"
      "ALT SHIFT, 3, exec, ${config.home.homeDirectory}/.bin/switch-layout 2"

      ### xf86 buttons ###

      ", xf86KbdBrightnessDown, exec, ${config.home.homeDirectory}/.bin/brightness --dec"
      ", xf86KbdBrightnessUp, exec, ${config.home.homeDirectory}/.bin/brightness --inc"
      ", xf86MonBrightnessDown, exec, ${config.home.homeDirectory}/.bin/brightness --dec"
      ", xf86MonBrightnessUp, exec, ${config.home.homeDirectory}/.bin/brightness --inc"

      ", xf86audioraisevolume, exec, ${config.home.homeDirectory}/.bin/volume --inc"
      ", xf86audiolowervolume, exec, ${config.home.homeDirectory}/.bin/volume --dec"
      ", XF86Calculator, exec, ${config.home.homeDirectory}/.bin/volume --inc"
      ", XF86HomePage, exec, ${config.home.homeDirectory}/.bin/volume --dec"

      ", xf86audiomute, exec, ${config.home.homeDirectory}/.bin/volume --toggle"
      ", xf86AudioMicMute, exec, ${config.home.homeDirectory}/.bin/volume --toggle-mic"
      ", XF86Mail, exec, ${config.home.homeDirectory}/.bin/volume --toggle-mic"
      ", XF86Tools, exec, ${config.home.homeDirectory}/.bin/volume --toggle-mic"

      ", xf86audioplay, exec, playerctl play-pause"
      ", XF86audiopause, exec, playerctl play-pause"
      ", xf86audionext, exec, playerctl next"
      ", xf86audioprev, exec, playerctl previous"
      ", xf86audiostop, exec, playerctl stop"
      ", XF86Search, exec, playerctl stop"
    ];
  };
}
