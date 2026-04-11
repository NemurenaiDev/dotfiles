{
  lib,
  host,
  hasRole,
  ...
}:

{
  imports = [
    ./docker.nix
  ]
  ++ lib.optionals (hasRole "desktop") [
    ./gamepad.nix
    ./mangohud.nix
  ]
  ++ lib.optionals (host ? snapserver) [ ./snapserver.nix ]
  ++ lib.optionals (host ? snapclients) [ ./snapclients.nix ];
}
