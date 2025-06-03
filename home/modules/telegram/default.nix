{ config, ... }:

{
  home.activation."link-telegram-downloads-to-tmp" = ''
    mkdir -p /tmp/TelegramDownloads

    rm -f ${config.home.homeDirectory}/Downloads/Telegram\ Desktop

    ln -sf /tmp/TelegramDownloads ${config.home.homeDirectory}/Downloads/Telegram\ Desktop
  '';

  home.file.".local/share/TelegramDesktop/tdata/shortcuts-custom.json" = {
    force = true;
    text = ''
      [
          {
              "command": "account1",
              "keys": "alt+1"
          },
          {
              "command": "account2",
              "keys": "alt+2"
          },
          {
              "command": "account3",
              "keys": "alt+3"
          },
          {
              "command": "account4",
              "keys": "alt+4"
          },
          {
              "command": "account5",
              "keys": "alt+5"
          },
          {
              "command": "account6",
              "keys": "alt+6"
          },
          {
              "command": "previous_folder",
              "keys": "alt+q"
          },
          {
              "command": "next_folder",
              "keys": "alt+e"
          }
      ]
    '';
  };
}
