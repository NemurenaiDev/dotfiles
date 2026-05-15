{ pkgs, host, ... }:

let
  snapconf = pkgs.writeText "snapserver.conf" ''
    [http]
    enabled=false
    port=1780
    bind_to_address=127.0.0.1

    [stream]
    codec=${host.snapserver.codec}
    buffer=${toString host.snapserver.buffer}
    source=pipewire://?name=Snapcast&auto_connect=true

    [tcp-control]
    enabled=true
    port=1705
    bind_to_address=0.0.0.0

    [tcp-streaming]
    enabled=true
    port=1704
    bind_to_address=0.0.0.0
  '';
in
{
  home.packages = [ pkgs.snapcast ];

  systemd.user.services.snapserver = {
    Unit = {
      Description = "Snapcast server daemon";
      After = [ "pipewire.service" ];
      Wants = [ "pipewire.service" ];
      BindsTo = [ "pipewire.service" ];
    };
    Service = {
      ExecStart = "${pkgs.snapcast}/bin/snapserver --config ${snapconf}";
      Restart = "always";
      RestartSec = "3s";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Make a "default" sink that outputs to the default sink for independent volume control in system and snapcast
  xdg.configFile."pipewire/pipewire.conf.d/99-virtual-sink.conf".text = ''
    context.modules = [
      {
        name = "libpipewire-module-loopback"
        args = {
          node.description = "Default"
          capture.props = {
            "node.name" = "default"
            "media.class" = "Audio/Sink"
          }
        }
      }
    ]
  '';
}
