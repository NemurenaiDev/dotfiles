{ host, ... }:

{
  services.librespot = {
    enable = true;
    settings = {
      name = "librespot@${host.hostname}";
      device-type = "speaker";

      ap-port = 57631;
      zeroconf-port = 57632;
      
      bitrate = 320;
      initial-volume = 100;
      
      enable-volume-normalisation = true;
      disable-credential-cache = true;
    };
  };
}
