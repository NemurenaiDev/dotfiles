{ host, lib, ... }:

{
  services.snapserver = lib.optionalAttrs (host ? snapserver) {
    enable = true;
    openFirewall = true;

    settings = {
      http.enabled = false;

      stream = {
        codec = host.snapserver.codec;
        buffer = host.snapserver.buffer;
        source = [ "pipe:///run/snapserver/pipewire?name=pipewire" ];
      };
    };
  };
}
