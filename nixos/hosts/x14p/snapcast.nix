{ pkgs, ... }:

{
  services.snapserver = {
    enable = true;
    openFirewall = true;
    codec = "flac";
    buffer = 400;
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

  # pactl load-module module-pipe-sink file=/run/snapserver/pipewire sink_name=Snapcast format=s16le rate=48000
  # pactl unload-module "$(pactl list sinks | grep "Snapcast" -A 3 | grep pulse.module.id | grep -oP "\d+")"; pactl load-module module-pipe-sink file=/run/snapserver/pipewire sink_name=Snapcast format=s16le rate=48000
}
