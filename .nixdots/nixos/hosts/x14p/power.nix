{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.kernelParams = [
    "ahci.mobile_lpm_policy=3"
    "rtc_cmos.use_acpi_alarm=1"
  ];

  systemd.tmpfiles.rules = [
    "w /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference - - - - balance_power"
  ];

  powerManagement.enable = true;
  powerManagement.powertop.enable = false;

  services.thermald.enable = false;
  services.power-profiles-daemon.enable = false;
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
}
