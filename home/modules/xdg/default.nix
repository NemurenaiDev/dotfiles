{ lib, hasRole, ... }:

{
  imports = lib.optionals (hasRole "desktop") [
    ./apps/browser.nix
    ./apps/vscode.nix
  ];

  config.xdg.enable = true;
}
