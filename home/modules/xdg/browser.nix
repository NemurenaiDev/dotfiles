{ config, lib, ... }:

{
  xdg.desktopEntries.zen = lib.mkForce {
    name = "stub";
    exec = "true";
    type = "Application";
    noDisplay = true;
  };

  xdg.desktopEntries.browser = {
    name = "Zen Browser";
    exec = "zen --profile ${config.home.homeDirectory}/.zen/x6xuobo4.nemurenai %u";
    icon = "zen";
    type = "Application";
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "application/x-xpinstall"
      "application/pdf"
      "application/json"
    ];
    categories = [
      "Network"
      "WebBrowser"
    ];
    startupNotify = true;
    terminal = false;
    settings = {
      "X-MultipleArgs" = "false";
      "Keywords" = "Internet;WWW;Browser;Web;Explorer;";
    };
  };
}
