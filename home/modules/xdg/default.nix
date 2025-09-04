{ config, ... }:

{
  imports = [
    ./apps/browser.nix
    ./apps/vscode.nix

    ./mime.nix
  ];

  home.activation."link-desktop-to-applications" = ''
    desktopPath="${config.home.homeDirectory}/.local/share/applications/Desktop"
    desktopLinkPath="${config.home.homeDirectory}/Desktop"

    [ -f "$desktopLinkPath" ] && rm -f "$desktopLinkPath"
    [ -f "$desktopPath" ] && rm -f "$desktopPath"

    mkdir -p "$desktopPath"

    ln -sfn "$desktopPath" "$desktopLinkPath"
  '';
}
