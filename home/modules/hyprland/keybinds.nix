{ host, ... }:

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

      "SUPER ALT, F1, exec, hyprctl -j activewindow > /tmp/.windowinfo && kitty --single-instance --class kitty-windowinfo sh -c 'cat /tmp/.windowinfo | moor -no-linenumbers'"

      "SUPER SHIFT, F11, exec, hyprctl reload config-only"
      "SUPER SHIFT, F12, exec, systemctl --user restart app-waybar"

      "SUPER SHIFT, L, exec, run-powermenu"

      "SUPER, L, exec, loginctl lock-session"

      ### utility apps ###

      "SUPER, code:49, exec, kitty --single-instance"

      "SUPER, V, exec, copyq show"

      "SUPER, S, exec, fuzzel"

      "SUPER, E, exec, nemo"

      "SUPER SHIFT, C, exec, hyprpicker --autocopy --no-fancy --render-inactive"

      ### workspace-specific applications ###

      "SUPER, W, exec, run-on-workspace '21' 'zen'"
      "SUPER SHIFT, W, movetoworkspace, 21"

      "SUPER, A, exec, run-on-workspace '22' 'zen --private-window'"
      "SUPER SHIFT, A, movetoworkspace, 22"

      "SUPER, X, exec, run-on-workspace '25' 'Telegram'"
      "SUPER SHIFT, X, movetoworkspace, 25"

      "SUPER, F3, exec, run-on-workspace '36' 'spotify --enable-features=UseOzonePlatform --ozone-platform-hint=wayland'"
      "SUPER, F4, exec, run-on-workspace '39' 'obs'"

      "SUPER, TAB, exec, run-on-workspace 'special:aichat' 'chromium --app=https://chatgpt.com/'"

      ### audio & bluetooth ###

      "SUPER, G, exec, run-sink-selector"
      "SUPER SHIFT, G, exec, pavucontrol"
      "SUPER ALT, G, exec, blueman-manager"

      ### screenshot ###

      ", Print, exec, /home/${host.username}/.bin/screenshot --screen"
      
      "SUPER ALT, S, exec, /home/${host.username}/.bin/screenshot --win"
      "SUPER CTRL, S, exec, /home/${host.username}/.bin/screenshot --screen"
      "SUPER SHIFT, S, exec, /home/${host.username}/.bin/screenshot --area"

      "SUPER SHIFT, R, exec, /home/${host.username}/.bin/screenshot --ocr-area"

      ### focus control & groups control ###

      "ALT, Tab, exec, hyprctl activewindow -j | jq -e '.grouped | length > 1' && hyprctl dispatch changegroupactive || hyprctl dispatch cyclenext"

      "SUPER, escape, focusmonitor, +1"

      "SUPER, T, togglegroup"
      "SUPER SHIFT, T, lockactivegroup, toggle"

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

      "SUPER SHIFT, escape, movewindow, mon:+1"

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

      "SUPER CTRL, escape, movecurrentworkspacetomonitor, +1"

      ### keyboard layout ###

      "ALT SHIFT, 1, exec, /home/${host.username}/.bin/switch-layout 0"
      "ALT SHIFT, 2, exec, /home/${host.username}/.bin/switch-layout 1"
      "ALT SHIFT, 3, exec, /home/${host.username}/.bin/switch-layout 2"

      ### xf86 buttons ###

      ", xf86MonBrightnessDown, exec, /home/${host.username}/.bin/brightness --dec"
      ", xf86MonBrightnessUp, exec, /home/${host.username}/.bin/brightness --inc"

      ", xf86AudioRaiseVolume, exec, /home/${host.username}/.bin/volume --inc"
      ", xf86AudioLowerVolume, exec, /home/${host.username}/.bin/volume --dec"
      ", XF86AudioMicMute, exec, /home/${host.username}/.bin/volume --toggle-mic"
      ", XF86AudioMute, exec, /home/${host.username}/.bin/volume --toggle-mic"

      ", xf86AudioStop, exec, playerctl stop"
      ", xf86AudioPlay, exec, playerctl play-pause"
      ", xf86AudioPause, exec, playerctl play-pause"
      ", xf86AudioNext, exec, playerctl next"
      ", xf86AudioPrev, exec, playerctl previous"

      ", F21, exec, /home/${host.username}/.bin/volume --toggle-mic"
      ", F22, exec, playerctl play-pause"
      ", F23, exec, playerctl previous"
      ", F24, exec, playerctl next"
    ];
  };
}
