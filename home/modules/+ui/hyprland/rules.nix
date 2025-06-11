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
      "workspace 26, initialClass:(vesktop)"
      "fullscreenstate * 2, initialClass:(code)"

      "float, initialClass:(vivaldi), initialTitle:(Settings)"
      "center, initialClass:(vivaldi), initialTitle:(Settings)"
      "size 960 720, initialClass:(vivaldi), initialTitle:(Settings)"

      "float, initialClass:(vivaldi), initialTitle:(Bitwarden)"
      "center, initialClass:(vivaldi), initialTitle:(Bitwarden)"
      "size 400 720, initialClass:(vivaldi), initialTitle:(Bitwarden)"

      "float, initialClass:(chromium-browser), initialTitle:(about:blank - Google Chrome for Testing)"
      "center, initialClass:(chromium-browser), initialTitle:(about:blank - Google Chrome for Testing)"
      "monitor ${leftOrCentral}, initialClass:(chromium-browser), initialTitle:(about:blank - Google Chrome for Testing)"
      "size 1600 900, initialClass:(chromium-browser), initialTitle:(about:blank - Google Chrome for Testing)"

      "pin, initialClass:(org.telegram.desktop), initialTitle:(^(?!.*(Telegram|Vladyslav|Media viewer)).+$)"
      "float, initialClass:(org.telegram.desktop), initialTitle:(^(?!.*(Telegram|Vladyslav|Media viewer)).+$)"
      "monitor ${leftOrCentral}, initialClass:(org.telegram.desktop), initialTitle:(^(?!.*(Telegram|Vladyslav|Media viewer)).+$)"
      "move 100%-w-6 41, initialClass:(org.telegram.desktop), initialTitle:(^(?!.*(Telegram|Vladyslav|Media viewer)).+$)"
      "size 380 580, initialClass:(org.telegram.desktop), initialTitle:(^(?!.*(Telegram|Vladyslav|Media viewer)).+$)"

      "monitor ${central}, initialClass:(org.telegram.desktop), initialTitle:(Telegram|Vladyslav|Media viewer)"
      "float, initialClass:(org.telegram.desktop), initialTitle:(Media viewer)"
      "tile, initialClass:(org.telegram.desktop), initialTitle:(Telegram|Vladyslav)"

      "monitor ${central}, initialClass:(polkit-gnome-authentication-agent-1)"

      "pin, initialClass:(nm-)"
      "pin, initialClass:(blueman)"
      "pin, initialClass:(polkit-gnome-authentication-agent-1)"

      "float, initialClass:(nm-)"
      "float, initialClass:(qt5ct)"
      "float, initialClass:(blueman)"
      "float, initialClass:(file-roller|FileRoller)"
      "float, initialClass:(Electron), initialTitle:(Permission)"

      "center, initialTitle:(Java)"
      "center, initialClass:(nm-)"
      "center, initialClass:(qt5ct)"
      "center, initialClass:(blueman)"
      "center, initialClass:(file-roller|FileRoller)"
      "center, initialClass:(Electron), initialTitle:(Permission)"

      "float, initialClass:(Steam|steam), initialTitle:(Steam )"
      "float, initialClass:(Steam|steam), initialTitle:(^(?!.*(?:Steam|steam)).*)"
      "center, initialClass:(Steam|steam), initialTitle:(Steam )"

      "float, initialClass:(Steam|steam), initialTitle:(Screenshot)"
      "center, initialClass:(Steam|steam), initialTitle:(Screenshot)"
      "size 1600 900, initialClass:(Steam|steam), initialTitle:(Screenshot)"

      "float, initialClass:(net.lutris.Lutris), initialTitle:(Lutris)"
      "center, initialClass:(net.lutris.Lutris), initialTitle:(Lutris)"
      "size 1200 720, initialClass:(net.lutris.Lutris), initialTitle:(Lutris)"

      "size 400 100, initialClass:(minecraft-launcher)"

      "float, initialClass:(minecraft-launcher|Minecraft Launcher)"
      "center, initialClass:(minecraft-launcher|Minecraft Launcher)"
      "workspace 1, initialClass:(minecraft-launcher|Minecraft Launcher)"

      "noborder true, initialClass:(steam_app|osu!|starbound|factorio), initialTitle:(^(?!.*(Error|Setup)).+$)"
      "workspace 1, initialClass:(steam_app|osu!|starbound|factorio), initialTitle:(^(?!.*(Error|Setup)).+$)"
      "fullscreen, initialClass:(steam_app|osu!|starbound|factorio), initialTitle:(^(?!.*(Error|Setup)).+$)"
      "immediate, initialClass:(steam_app|osu!|starbound|factorio), initialTitle:(^(?!.*(Error|Setup)).+$)"

      "pin, initialClass:(kitty-powermenu)"
      "float, initialClass:(kitty-powermenu)"
      "center, initialClass:(kitty-powermenu)"
      "size 200 150, initialClass:(kitty-powermenu)"

      "pin, initialClass:(kitty-project)"
      "float, initialClass:(kitty-project)"
      "center, initialClass:(kitty-project)"
      "size 800 450, initialClass:(kitty-project)"

      "pin, initialClass:(kitty-pulsemixer)"
      "float, initialClass:(kitty-pulsemixer)"
      "center, initialClass:(kitty-pulsemixer)"
      "size 800 450, initialClass:(kitty-pulsemixer)"

      "pin, initialTitle:(Picture.in..icture)"
      "float, initialTitle:(Picture.in..icture)"
      "monitor ${leftOrCentral}, initialTitle:(Picture.in..icture)"
      "noinitialfocus, initialTitle:(Picture.in..icture)"
      "size 500 300, initialTitle:(Picture.in..icture)"
      "move 100%-506 100%-301, initialTitle:(Picture.in..icture)"

      "float, initialClass:(dconf-editor)"
      "center, initialClass:(dconf-editor)"
      "size 1600 900, initialClass:(dconf-editor)"

      "float, initialClass:(mpv|eog|Eog)"
      "center, initialClass:(mpv|eog|Eog)"
      "size 96% 92.5%, initialClass:(mpv|eog|Eog)"
      "move 2% 5%, initialClass:(mpv|eog|Eog)"

      "float, initialTitle:(Confirm)"
      "center, initialTitle:(Confirm)"
      "size 960 300, initialTitle:(Confirm)"

      "float, initialTitle:(Rename|File Operation)"
      "center, initialTitle:(Rename|File Operation)"
      "size 450 150, initialTitle:(Rename|File Operation)"

      "pin, initialClass:(blueman-manager|blueman-services|blueman-sendto)"
      "float, initialClass:(blueman-manager|blueman-services|blueman-sendto)"
      "center, initialClass:(blueman-manager|blueman-services|blueman-sendto)"
      "size 640 480, initialClass:(blueman-manager|blueman-services|blueman-sendto)"

      "pin, initialClass:(blueman|nm-connection-editor)"
      "float, initialClass:(blueman|nm-connection-editor)"
      "center, initialClass:(blueman|nm-connection-editor)"
      "maxsize 960 720, initialClass:(blueman|nm-connection-editor)"

      "pin, initialClass:(com.github.hluk.copyq)"
      "float, initialClass:(com.github.hluk.copyq)"
      "center, initialClass:(com.github.hluk.copyq)"
      "stayfocused, initialClass:(com.github.hluk.copyq)"
      "size 960 720, initialClass:(com.github.hluk.copyq)"

      "float, initialClass:(pavucontrol|com.github.wwmm.easyeffects)"
      "center, initialClass:(pavucontrol|com.github.wwmm.easyeffects)"
      "size 960 720, initialClass:(pavucontrol|com.github.wwmm.easyeffects)"
    ];
  };
}
