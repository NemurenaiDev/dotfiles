{ lib, host, ... }:

{
  imports =
    [ ]
    ++ lib.optionals (host ? snapserver) [ ./snapserver.nix ]
    ++ lib.optionals (host ? snapclients) [ ./snapclients.nix ];
}
