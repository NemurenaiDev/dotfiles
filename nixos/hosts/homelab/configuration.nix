{ pkgs, ... }:

{
  imports = [
    ./../../default.configuration.nix
    ./hardware.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 0;

  hardware.cpu.intel.updateMicrocode = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.disabledPlugins = [ "PowerManager" ];

  hardware.firmware = [ pkgs.linux-firmware ];

  services.system76-scheduler.enable = true;
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  services.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "schedutil";
        turbo = "always";
      };
    };
  };
}
