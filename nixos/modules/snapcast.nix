{ host, lib, ... }:

{
  services.snapserver = lib.optionalAttrs (host ? snapserver) {
    enable = true;
    openFirewall = true;

    settings = {
      http.enabled = true;
      http.bind_to_address = "127.0.0.1";

      tcp-control.enabled = true;
      tcp-control.bind_to_address = "0.0.0.0";

      tcp-streaming.enabled = true;
      tcp-streaming.bind_to_address = "0.0.0.0";

      stream = {
        codec = host.snapserver.codec;
        buffer = host.snapserver.buffer;
        source = [ "pipe:///run/snapserver/pipewire?name=pipewire" ];
      };
    };
  };
}
