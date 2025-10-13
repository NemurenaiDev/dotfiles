{ host, ... }:

{
  services.librespot = {
    enable = true;
    settings = {
      name = "${host.username}@${host.hostname}";
      device-type = "speaker";

      bitrate = 320;
      initial-volume = 100;
      
      enable-volume-normalisation = true;
      disable-credential-cache = true;
    };
  };
}
