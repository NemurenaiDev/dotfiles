{ host, ... }:

{
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        bitrate = 320;
        initial_volume = 100;
        volume_normalisation = false;
        device_type = "computer";
        device_name = "${host.username}@${host.hostname}";
      };
    };
  };
}
