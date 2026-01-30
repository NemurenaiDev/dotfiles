{ host, ... }:

{
  services.librespot = {
    enable = true;
    settings = {
      name = "librespot@${host.hostname}";
      device-type = "speaker";

      bitrate = 320;
      initial-volume = 100;
      
      zeroconf-port = 57632;

      enable-oauth = true;
    };
  };
}
