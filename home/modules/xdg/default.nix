{ lib, hasRole, ... }:

{
  imports = lib.optionals (hasRole "desktop") [
    ./apps/browser.nix
    ./apps/vscode.nix

    ./npm-clean.nix

    ./xdg-jail.nix
  ];

  config.xdg.enable = true;
}
