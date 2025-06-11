{ lib, ... }:

{
  boot.kernelParams = [
    "quiet"
    "splash"
    "udev.log_priority=3"
    "vt.global_cursor_default=0"
    "rd.systemd.show_status=auto"
  ];
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.plymouth.enable = true;
  boot.plymouth.theme = "spinner";

  # systemd.services.plymouth-quit.enable = lib.mkForce false;
  # systemd.services.plymouth-quit-wait.enable = lib.mkForce false;

  # systemd.services.plymouth-quit.wantedBy = lib.mkForce [ ];
  # systemd.services.plymouth-quit-wait.wantedBy = lib.mkForce [ ];
}
