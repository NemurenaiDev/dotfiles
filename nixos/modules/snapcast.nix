{
  pkgs,
  host,
  lib,
  ...
}:

{
  services.snapserver = lib.optionalAttrs (host ? snapserver) {
    enable = true;
    openFirewall = true;
    codec = host.snapserver.codec;
    buffer = host.snapserver.buffer;
    http = {
      enable = true;
      listenAddress = "192.168.0.0";
      docRoot = "${pkgs.snapcast}/share/snapserver/snapweb/";
    };
    streams = {
      pipewire = {
        type = "pipe";
        location = "/run/snapserver/pipewire";
      };
    };
  };
}
