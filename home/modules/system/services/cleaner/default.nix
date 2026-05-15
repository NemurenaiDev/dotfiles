{ pkgs, ... }:

{
  systemd.user.services.cleaner = {
    Unit.Description = "Forcefully remove ~/.npm";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/rm -rf %h/.npm";
    };
    Install.WantedBy = [ "default.target" ];
  };

  systemd.user.timers.cleaner = {
    Unit.Description = "Trigger cleaner.service every 60 seconds";
    Timer = {
      OnUnitActiveSec = "60s";
      Persistent = true;
      Unit = "cleaner.service";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
