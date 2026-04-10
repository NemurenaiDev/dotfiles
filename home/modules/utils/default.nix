{ lib, hasRole, ... }:

{
  imports = [
    ./docker.nix

    ./snapcast.nix
  ]
  ++ lib.optionals (hasRole "desktop") [
    ./gamepad.nix
    ./mangohud.nix
  ];
}
