{
  config,
  host,
  pkgs,
  ...
}:

{
  home.activation."link-telegram-downloads-to-tmp" = ''
    ${pkgs.coreutils}/bin/mkdir -p ${config.home.homeDirectory}/Downloads
    ${pkgs.coreutils}/bin/rm -rf ${config.home.homeDirectory}/Downloads/Telegram\ Desktop

    ${pkgs.coreutils}/bin/mkdir -p /tmp/${host.username}/TelegramDownloads
    ${pkgs.coreutils}/bin/ln -sf /tmp/${host.username}/TelegramDownloads ${config.home.homeDirectory}/Downloads/Telegram\ Desktop
  '';

  xdg.dataFile."TelegramDesktop/tdata/shortcuts-custom.json" = {
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
