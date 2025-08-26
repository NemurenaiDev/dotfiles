{ monitors, ... }:

let
  central = monitors.central;
  leftOrCentral = monitors.left or monitors.central;
in
{
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur, launcher"
      "dimaround, launcher"
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

      "13, monitor:${central}, default:true"

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

    windowrulev2 = [
      "bordersize 1, floating:1"
      "workspace 26, initialClass:vesktop"
      "fullscreenstate * 2, initialClass:code"

      "float, initialClass:zen, title:Extension.*Bitwarden.*"
      "center, initialClass:zen, title:Extension.*Bitwarden.*"
      "size 400 720, initialClass:zen, title:Extension.*Bitwarden.*"

      "monitor ${central}, initialClass:.*polkit.*auth.*"

      "pin, initialClass:.*nm-.*"
      "pin, initialClass:.*blueman.*"
      "pin, initialClass:.*polkit.*auth.*"

      "float, initialClass:.*nm-.*"
      "float, initialClass:.*blueman.*"
      "float, initialClass:.*(file-roller|FileRoller).*"

      "center, initialClass:.*nm-.*"
      "center, initialClass:.*blueman.*"
      "center, initialClass:.*(file-roller|FileRoller).*"

      "float, initialClass:Steam|steam"
      "center, initialClass:Steam|steam"

      "tile, initialClass:Steam|steam, initialTitle:^Steam$"

      "size 1600 900, initialClass:Steam|steam, initialTitle:Screenshot"

      "renderunfocused, initialClass:steam_app_1086940, initialTitle:Baldur.s.Gate.3.*"

      "float, initialClass:.*lutris.*, initialTitle:Lutris"
      "center, initialClass:.*lutris.*, initialTitle:Lutris"
      "size 1200 720, initialClass:.*lutris.*, initialTitle:Lutris"

      "pin, initialClass:kitty-.*"
      "float, initialClass:kitty-.*"
      "center, initialClass:kitty-.*"
      "size 200 150, initialClass:kitty-powermenu"
      "size 300 200, initialClass:kitty-sink-selector"
      "size 800 450, initialClass:kitty-pulsemixer"
      "size 800 450, initialClass:kitty-project"

      "pin, initialTitle:Picture.in..icture"
      "float, initialTitle:Picture.in..icture"
      "monitor ${leftOrCentral}, initialTitle:Picture.in..icture"
      "noinitialfocus, initialTitle:Picture.in..icture"
      "size 500 300, initialTitle:Picture.in..icture"
      "move 100%-506 100%-301, initialTitle:Picture.in..icture"

      "float, initialClass:dconf-editor"
      "center, initialClass:dconf-editor"
      "size 1600 900, initialClass:dconf-editor"

      "float, initialClass:mpv|eog|Eog"
      "center, initialClass:mpv|eog|Eog"
      "size 96% 92.5%, initialClass:mpv|eog|Eog"
      "move 2% 5%, initialClass:mpv|eog|Eog"

      "float, initialTitle:Confirm"
      "center, initialTitle:Confirm"
      "size 960 300, initialTitle:Confirm"

      "float, initialTitle:Rename|File Operation"
      "center, initialTitle:Rename|File Operation"
      "size 450 150, initialTitle:Rename|File Operation"

      "float, initialTitle:File Upload"
      "center, initialTitle:File Upload"
      "size 960 720, initialTitle:File Upload"

      "pin, initialClass:.*blueman.*|.*nm-connection-editor.*"
      "float, initialClass:.*blueman.*|.*nm-connection-editor.*"
      "center, initialClass:.*blueman.*|.*nm-connection-editor.*"
      "maxsize 960 720, initialClass:.*blueman.*|.*nm-connection-editor.*"

      "size 640 480, initialClass:.*blueman-manager.*|.*blueman-services.*|.*blueman-sendto.*"

      "pin, initialClass:.*copyq.*"
      "float, initialClass:.*copyq.*"
      "center, initialClass:.*copyq.*"
      "size 960 720, initialClass:.*copyq.*"

      "float, initialClass:.*pavucontrol.*|.*easyeffects.*"
      "center, initialClass:.*pavucontrol.*|.*easyeffects.*"
      "size 960 720, initialClass:.*pavucontrol.*|.*easyeffects.*"
    ];
  };
}
