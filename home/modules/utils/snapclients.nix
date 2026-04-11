{
  pkgs,
  host,
  lib,
  ...
}:

{
  home.packages = [ pkgs.snapcast ];

  systemd.user.services = builtins.listToAttrs (
    map (hostAddr: {
      name = "snapclient-${lib.replaceStrings [ "." ] [ "-" ] hostAddr}";
      value = {
        Unit = {
          Description = "Snapclient for ${hostAddr}";
          After = [
            "network-online.target"
            "pipewire.service"
          ];
          Wants = [
            "network-online.target"
            "pipewire.service"
          ];
          PartOf = [ "pipewire.service" ];
        };
        Service = {
          ExecStart = "${pkgs.snapcast}/bin/snapclient --host ${hostAddr}";
          Restart = "always";
          RestartSec = "3s";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    }) host.snapclients
  );
}
