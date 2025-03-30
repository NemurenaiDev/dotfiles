{ config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur, launcher"
      "dimaround, launcher"
    ];

    workspace = [
      "1, monitor:$MonitorCenter, default:true, gapsout:0"
      "2, monitor:$MonitorCenter, default:true, gapsout:0"
      "3, monitor:$MonitorCenter, default:true, gapsout:0"
      "4, monitor:$MonitorCenter, default:true, gapsout:0"
      "5, monitor:$MonitorCenter, default:true, gapsout:0"
      "6, monitor:$MonitorCenter, default:true, gapsout:0"
      "7, monitor:$MonitorCenter, default:true, gapsout:0"
      "8, monitor:$MonitorCenter, default:true, gapsout:0"

      "9, monitor:$MonitorLeft, default:true"
      "10, monitor:$MonitorLeft, default:true"

      "11, monitor:$MonitorLeft, default:true"
      "12, monitor:$MonitorLeft, default:true"
      "13, monitor:$MonitorLeft, default:true"
      "14, monitor:$MonitorLeft, default:true"
      "15, monitor:$MonitorLeft, default:true"
      "16, monitor:$MonitorLeft, default:true"
      "17, monitor:$MonitorLeft, default:true"
      "18, monitor:$MonitorLeft, default:true"
      "19, monitor:$MonitorLeft, default:true"
      "20, monitor:$MonitorLeft, default:true"

      "21, monitor:$MonitorCenter, default:true, gapsout:0"
      "22, monitor:$MonitorCenter, default:true, gapsout:0"
      "23, monitor:$MonitorCenter, default:true, gapsout:0"
      "24, monitor:$MonitorCenter, default:true, gapsout:0"
      "25, monitor:$MonitorCenter, default:true, gapsout:80"

      "26, monitor:$MonitorLeft, default:true"

      "27, monitor:$MonitorCenter, default:true, gapsout:0"
      "28, monitor:$MonitorCenter, default:true, gapsout:0"
      "29, monitor:$MonitorCenter, default:true, gapsout:0"
      "30, monitor:$MonitorCenter, default:true, gapsout:0"

      "31, monitor:$MonitorCenter, default:true, gapsout:0"
      "32, monitor:$MonitorCenter, default:true, gapsout:0"
      "33, monitor:$MonitorCenter, default:true, gapsout:0"
      "34, monitor:$MonitorCenter, default:true, gapsout:0"
      "35, monitor:$MonitorCenter, default:true, gapsout:0"

      "36, monitor:$MonitorLeft, default:true"
      "37, monitor:$MonitorLeft, default:true"
      "38, monitor:$MonitorLeft, default:true"
      "39, monitor:$MonitorLeft, default:true"

      "m[$MonitorCenter], bordersize:0"

      "special:chatgpt, gapsout:50"
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
      "monitor $MonitorLeft, initialClass:(chromium-browser), initialTitle:(about:blank - Google Chrome for Testing)"
      "size 1600 900, initialClass:(chromium-browser), initialTitle:(about:blank - Google Chrome for Testing)"

      "pin, initialClass:(org.telegram.desktop), initialTitle:(^(?!.*(Telegram|Vladyslav|Media viewer)).+$)"
      "float, initialClass:(org.telegram.desktop), initialTitle:(^(?!.*(Telegram|Vladyslav|Media viewer)).+$)"
      "monitor $MonitorLeft, initialClass:(org.telegram.desktop), initialTitle:(^(?!.*(Telegram|Vladyslav|Media viewer)).+$)"
      "move 100%-w-6 41, initialClass:(org.telegram.desktop), initialTitle:(^(?!.*(Telegram|Vladyslav|Media viewer)).+$)"
      "size 380 580, initialClass:(org.telegram.desktop), initialTitle:(^(?!.*(Telegram|Vladyslav|Media viewer)).+$)"

      "monitor $MonitorCenter, initialClass:(org.telegram.desktop), initialTitle:(Telegram|Vladyslav|Media viewer)"
      "float, initialClass:(org.telegram.desktop), initialTitle:(Media viewer)"
      "tile, initialClass:(org.telegram.desktop), initialTitle:(Telegram|Vladyslav)"

      "monitor $MonitorCenter, initialClass:(polkit-gnome-authentication-agent-1)"

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
      "monitor $MonitorLeft, initialTitle:(Picture.in..icture)"
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

      "float, initialTitle:(File Roller|Open.*|Save.*|Choose.*|All Files|Archive|Resize|Rotate|Theme File|Properties|Telegram Desktop - Thunar)"
      "center, initialTitle:(File Roller|Open.*|Save.*|Choose.*|All Files|Archive|Resize|Rotate|Theme File|Properties|Telegram Desktop - Thunar)"
      "size 960 720, initialTitle:(File Roller|Open.*|Save.*|Choose.*|All Files|Archive|Resize|Rotate|Theme File|Properties|Telegram Desktop - Thunar)"

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
