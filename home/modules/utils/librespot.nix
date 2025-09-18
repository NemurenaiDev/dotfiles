{ host, ... }:

{
  services.librespot = {
    enable = true;
    settings = {
      name = "${host.username}@${host.hostname}";
      device-type = "speaker";
      zeroconf-port = 57622;

      bitrate = 320;
      initial-volume = 100;
      enable-volume-normalisation = true;
    };
  };
}
