{ lib, ... }:

{
  xdg.desktopEntries.vivaldi-stable = lib.mkForce {
    name = "stub";
    exec = "true";
    type = "Application";
    noDisplay = true;
  };

  xdg.desktopEntries.vivaldi = lib.mkForce {
    name = "stub";
    exec = "true";
    type = "Application";
    noDisplay = true;
  };

  xdg.desktopEntries.browser = {
    name = "Vivaldi";
    exec = "vivaldi %u";
    icon = "vivaldi";
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
