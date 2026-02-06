{ monitors, ... }:

let
  central = monitors.central;
  leftOrCentral = monitors.left or monitors.central;
in
{
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur on, match:namespace (launcher)"
      "dim_around on, match:namespace (launcher)"
      "ignore_alpha 0, match:namespace (launcher)"

      "blur on, match:namespace (notifications)"
      "ignore_alpha 0, match:namespace (notifications)"
    ];

    workspace = [
      "1, monitor:${central}, default:true"
      "2, monitor:${central}, default:true"
      "3, monitor:${central}, default:true"
      "4, monitor:${central}, default:true"
      "5, monitor:${central}, default:true"
      "6, monitor:${central}, default:true"
      "7, monitor:${central}, default:true"
      "8, monitor:${central}, default:true"

      "9, monitor:${leftOrCentral}, default:true"
      "10, monitor:${leftOrCentral}, default:true"

      "11, monitor:${leftOrCentral}, default:true"
      "12, monitor:${leftOrCentral}, default:true"

      "13, monitor:${leftOrCentral}, default:true"
      "14, monitor:${leftOrCentral}, default:true"
      "15, monitor:${leftOrCentral}, default:true"
      "16, monitor:${leftOrCentral}, default:true"
      "17, monitor:${leftOrCentral}, default:true"
      "18, monitor:${leftOrCentral}, default:true"
      "19, monitor:${leftOrCentral}, default:true"
      "20, monitor:${leftOrCentral}, default:true"

      "21, monitor:${central}, default:true"
      "22, monitor:${central}, default:true"
      "23, monitor:${central}, default:true"
      "24, monitor:${central}, default:true"
      "25, monitor:${central}, default:true, gapsout:80"

      "26, monitor:${leftOrCentral}, default:true"

      "27, monitor:${central}, default:true"
      "28, monitor:${central}, default:true"
      "29, monitor:${central}, default:true"
      "30, monitor:${central}, default:true"

      "31, monitor:${central}, default:true"
      "32, monitor:${central}, default:true"
      "33, monitor:${central}, default:true"
      "34, monitor:${central}, default:true"
      "35, monitor:${central}, default:true"

      "36, monitor:${leftOrCentral}, default:true"
      "37, monitor:${leftOrCentral}, default:true"
      "38, monitor:${leftOrCentral}, default:true"
      "39, monitor:${leftOrCentral}, default:true"

      "special:aichat, gapsout:50"
    ];

    windowrule = [

      ### other ###

      "border_size 0, match:workspace w[tv1]"
      "border_size 1, match:float true"

      "workspace special:aichat silent, match:class (.*chrome-chatgpt.*)"

      "workspace special:hidden silent, match:class (^$), match:title (LibreOffice)"
      "workspace special:hidden silent, match:class (^$), match:title (.*is.sharing.*)"
      "workspace special:hidden silent, match:class (nemo), match:title (nemo.*/.local/share/nemo)"

      "workspace 26, match:class (vesktop)"

      "float on, match:class (zen|chromium), match:title negative:(Picture-in-Picture)"
      "size 600 765, match:class (zen|chromium), match:title negative:(Picture-in-Picture)"

      "fullscreen_state 0 2, match:class (code)"

      "move cursor 0 0, match:class (Unity), match:title (UnityEditor.PopupWindow)"

      "suppress_event maximize, match:class (deluge)"

      "suppress_event maximize, match:class (libreoffice.*)"

      "suppress_event maximize, match:class (org.telegram.desktop)"
      "suppress_event fullscreen, match:class (org.telegram.desktop)"

      "size 600 765, match:class (org.telegram.desktop), match:title (Mini.App.+)"
      "float on, match:class (org.telegram.desktop), match:title (Mini.App.+)"

      "float on, match:class (org.telegram.desktop), match:title (Media viewer)"
      "center on, match:class (org.telegram.desktop), match:title (Media viewer)"
      "move 30 50, match:class (org.telegram.desktop), match:title (Media viewer)"
      "size monitor_w-60 monitor_h-80, match:class (org.telegram.desktop), match:title (Media viewer)"

      ### gaming ###

      "float on, match:class (net.lutris.Lutris), match:title (Lutris.+)"
      "center on, match:class (net.lutris.Lutris), match:title (Lutris.+)"
      "size 1400 800, match:class (net.lutris.Lutris), match:title (Lutris.+)"

      "float on, match:class (Steam|steam), match:title negative:(Steam|Steam.Big.Picture.Mode)"

      "tile on, match:class (Steam|steam), match:title (Steam|Steam.Big.Picture.Mode)"
      "suppress_event fullscreen, match:class (Steam|steam), match:title (Steam|Steam.Big.Picture.Mode)"

      "size 1600 900, match:class (Steam|steam), match:title (.*Screenshot.*)"

      "fullscreen on, match:class (steam_app_.*)"

      ### dialogs ###

      "pin on, match:class (kitty-.*)"
      "float on, match:class (kitty-.*)"
      "center on, match:class (kitty-.*)"

      "size 200 150, match:class (kitty-powermenu)"
      "stay_focused on, match:initial_class (kitty-powermenu)"

      "size 300 200, match:class (kitty-sink-selector)"
      "stay_focused on, match:initial_class (kitty-sink-selector)"

      "size 800 450, match:class (kitty-project)"
      "stay_focused on, match:initial_class (kitty-project)"

      "size 1280 720, match:class (kitty-windowinfo)"

      ### media & docs ###

      "float on, match:class (soffice)"
      "center on, match:class (soffice)"
      "size 1200 720, match:class (soffice)"

      "pin on, match:title (Picture-in-Picture)"
      "float on, match:title (Picture-in-Picture)"
      "no_initial_focus on, match:title (Picture-in-Picture)"
      "size 500 300, match:title (Picture-in-Picture)"
      "move monitor_w-window_w-5 monitor_h-window_h-5, match:title (Picture-in-Picture)"

      "float on, match:class (org.kde.haruna|org.gnome.eog|mpv)"
      "center on, match:class (org.kde.haruna|org.gnome.eog|mpv)"
      "move 30 50, match:class (org.kde.haruna|org.gnome.eog|mpv)"
      "size monitor_w-60 monitor_h-80, match:class (org.kde.haruna|org.gnome.eog|mpv)"

      ### files ###

      "float on, match:class negative:(com.github.hluk.copyq), match:title (.*(Confirm).*)"
      "center on, match:class negative:(com.github.hluk.copyq), match:title (.*(Confirm).*)"
      "size 960 300, match:class negative:(com.github.hluk.copyq), match:title (.*(Confirm).*)"

      "float on, match:class negative:(com.github.hluk.copyq), match:title (.*(Rename|File.*Operation).*)"
      "center on, match:class negative:(com.github.hluk.copyq), match:title (.*(Rename|File.*Operation).*)"
      "size 450 150, match:class negative:(com.github.hluk.copyq), match:title (.*(Rename|File.*Operation).*)"

      "float on, match:class negative:(com.github.hluk.copyq), match:title (.*(Open.with).*)"
      "center on, match:class negative:(com.github.hluk.copyq), match:title (.*(Open.with).*)"
      "size 720 680, match:class negative:(com.github.hluk.copyq), match:title (.*(Open.with).*)"

      "float on, match:class negative:(com.github.hluk.copyq), match:title (.*(Upload|Choose|Select).*)"
      "center on, match:class negative:(com.github.hluk.copyq), match:title (.*(Upload|Choose|Select).*)"
      "size 960 720, match:class negative:(com.github.hluk.copyq), match:title (.*(Upload|Choose|Select).*)"

      ### utils ###

      "pin on, match:class (com.github.hluk.copyq)"
      "float on, match:class (com.github.hluk.copyq)"
      "center on, match:class (com.github.hluk.copyq)"
      "size 960 720, match:class (com.github.hluk.copyq)"

      "float on, match:class (dconf-editor)"
      "center on, match:class (dconf-editor)"
      "size 1600 900, match:class (dconf-editor)"

      "pin on, match:class (.*nm-.*)"
      "pin on, match:class (.*blueman.*)"

      "float on, match:class (.*nm-.*)"
      "float on, match:class (.*blueman.*)"

      "center on, match:class (.*nm-.*)"
      "center on, match:class (.*blueman.*)"

      "float on, match:class (.*(file-roller|FileRoller).*)"
      "center on, match:class (.*(file-roller|FileRoller).*)"
      "size 960 720, match:class (.*(file-roller|FileRoller).*)"

      "pin on, match:class (.*(blueman|nm-connection-editor).*)"
      "float on, match:class (.*(blueman|nm-connection-editor).*)"
      "center on, match:class (.*(blueman|nm-connection-editor).*)"
      "size 960 720, match:class (.*(blueman|nm-connection-editor).*)"

      "size 640 480, match:class (.*(blueman-manager|blueman-services|blueman-sendto).*)"

      "float on, match:class (.*(pavucontrol|easyeffects).*)"
      "center on, match:class (.*(pavucontrol|easyeffects).*)"
      "size 960 720, match:class (.*(pavucontrol|easyeffects).*)"
    ];
  };
}
