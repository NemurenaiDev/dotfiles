{ pkgs, ... }:

{
  systemd.user.services.npm-clean = {
    Unit.Description = "Forcefully remove ~/.npm";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/rm -rf %h/.npm";
    };
    Install.WantedBy = [ "default.target" ];
  };

  systemd.user.timers.npm-clean = {
    Unit.Description = "Trigger npm-clean.service every 60 seconds";
    Timer = {
      OnUnitActiveSec = "60s";
      Persistent = true;
      Unit = "npm-clean.service";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
