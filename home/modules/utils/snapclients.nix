{
  pkgs,
  host,
  lib,
  ...
}:

{
  home.packages = [ pkgs.snapcast ];

  systemd.user.targets.snapclients = {
    Unit = {
      Description = "Snapcast clients group";
      After = [ "pipewire.service" ];
      Wants = [ "pipewire.service" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services = builtins.listToAttrs (
    map (addr: {
      name = "snapclient-${lib.replaceStrings [ "." ] [ "-" ] addr}.service";
      value = {
        Unit = {
          Description = "Snapclient for ${addr}";
          After = [
            "pipewire.service"
            "snapclients.target"
          ];
          BindsTo = [
            "pipewire.service"
            "snapclients.target"
          ];
          PartOf = [ "snapclients.target" ];
        };
        Install = {
          WantedBy = [ "snapclients.target" ];
        };
        Service = {
          ExecStart = "${pkgs.snapcast}/bin/snapclient --host ${lib.escapeShellArg addr}";
          Restart = "always";
          RestartSec = "3s";
        };
      };
    }) host.snapclients
  );
}
