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

    settings = {
      http = {
        enabled = true;
        bind_to_address = "192.168.0.0";
        doc_root = "${pkgs.snapcast}/share/snapserver/snapweb/";
      };

      stream = {
        source = "pipe:///run/snapserver/pipewire?name=pipewire";
      };
    };
  };
}
