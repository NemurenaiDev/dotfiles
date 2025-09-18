{
  pkgs,
  host,
  lib,
  ...
}:

{
  systemd.user.services = lib.optionalAttrs (host ? snapserver) {
    snapcast-sink = {
      Unit = {
        Description = "Load Snapcast Sink";
        After = [
          "snapserver.service"
          "pipewire.service"
          "pipewire-pulse.service"
        ];
        Wants = [
          "snapserver.service"
          "pipewire.service"
          "pipewire-pulse.service"
        ];
        BindsTo = [
          "pipewire.service"
          "pipewire-pulse.service"
        ];
        PartOf = [
          "pipewire.service"
          "pipewire-pulse.service"
        ];
        ConditionPathExists = "/run/snapserver/pipewire";
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${(pkgs.writeShellScriptBin "load-snapcast-sink" ''
          # Default audio sink for volume control without touching device volume itself
          prevDefaultSink=$(${pkgs.pulseaudio}/bin/pactl list modules short | ${pkgs.gnugrep}/bin/grep "module-virtual-sink.*sink_name=default" | cut -f1)
          if [ -n "$prevDefaultSink" ]; then
            ${pkgs.pulseaudio}/bin/pactl unload-module "$prevDefaultSink"
          fi
          ${pkgs.pulseaudio}/bin/pactl load-module module-virtual-sink sink_name=default sink_properties=device.description="Default"

          # Snapcast sink
          prevSnapcastSink=$(${pkgs.pulseaudio}/bin/pactl list modules short | ${pkgs.gnugrep}/bin/grep "module-pipe-sink.*sink_name=Snapcast" | cut -f1)
          if [ -n "$prevSnapcastSink" ]; then
            ${pkgs.pulseaudio}/bin/pactl unload-module "$prevSnapcastSink"
          fi
          ${pkgs.pulseaudio}/bin/pactl load-module module-pipe-sink file=/run/snapserver/pipewire sink_name=Snapcast format=s16le rate=48000
        '')}/bin/load-snapcast-sink";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };

}
