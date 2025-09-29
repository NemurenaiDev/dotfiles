{
  pkgs,
  host,
  lib,
  ...
}:

{
  systemd.user.services =
    lib.optionalAttrs (host ? snapserver) {
      snapcast-sink-watcher = {
        Unit = {
          Description = "Watch Snapserver Pipes";
        };
        Service = {
          Type = "simple";
          Restart = "always";
          ExecStart = "${pkgs.writeShellScriptBin "snapcast-sink-watcher" ''
            [ -e /run/snapserver/pipewire ] && ${pkgs.inotify-tools}/bin/inotifywait -e create,delete,move /run/snapserver
          ''}/bin/snapcast-sink-watcher";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };

      snapcast-sink = {
        Unit = {
          Description = "Load Snapcast Sink";
          After = [
            "pipewire.service"
            "pipewire-pulse.service"
            "snapcast-sink-watcher.service"
          ];
          Wants = [
            "pipewire.service"
            "pipewire-pulse.service"
            "snapcast-sink-watcher.service"
          ];
          PartOf = [
            "pipewire.service"
            "pipewire-pulse.service"
            "snapcast-sink-watcher.service"
          ];
        };
        Service = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${(pkgs.writeShellScriptBin "reload-snapcast-sink" ''
            # Default audio sink for volume control without touching device volume itself
            prevDefaultSink=$(${pkgs.pulseaudio}/bin/pactl list modules short | ${pkgs.gnugrep}/bin/grep "module-virtual-sink.*sink_name=default" | cut -f1)
            if [ -z "$prevDefaultSink" ]; then
              ${pkgs.pulseaudio}/bin/pactl load-module module-virtual-sink sink_name=default sink_properties=device.description="Default"
            fi

            # Snapcast sink
            prevSnapcastSink=$(${pkgs.pulseaudio}/bin/pactl list modules short | ${pkgs.gnugrep}/bin/grep "module-pipe-sink.*sink_name=Snapcast" | cut -f1)
            if [ -n "$prevSnapcastSink" ]; then
              ${pkgs.pulseaudio}/bin/pactl unload-module "$prevSnapcastSink"
            fi
            ${pkgs.pulseaudio}/bin/pactl load-module module-pipe-sink file=/run/snapserver/pipewire sink_name=Snapcast format=s16le rate=48000
          '')}/bin/reload-snapcast-sink";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    }

    // builtins.listToAttrs (
      map (hostAddr: {
        name = "snapclient-${lib.replaceStrings [ "." ] [ "-" ] hostAddr}";
        value = {
          Unit = {
            Description = "Snapclient for ${hostAddr}";
            After = [ "network.target" ];
          };
          Service = {
            ExecStart = "${pkgs.snapcast}/bin/snapclient --host ${hostAddr}";
            Restart = "on-failure";
          };
          Install = {
            WantedBy = [ "default.target" ];
          };
        };
      }) host.snapclients
    );
}
