{ lib, hasRole, ... }:

{
  imports = [
    ./docker.nix

    ./snapcast.nix
    ./librespot.nix
  ]
  ++ lib.optionals (hasRole "desktop") [
    ./gamepad.nix
    ./mangohud.nix
  ];
}
