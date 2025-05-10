{ config, lib, pkgs, ... }:

{
  imports = [ ./../../default.configuration.nix ./hardware.nix ./snapcast.nix ];

  networking.hostName = "cyberia";
  time.timeZone = "Europe/Kyiv";
  system.stateVersion = "24.11";

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "rtc_cmos.use_acpi_alarm=1" ];
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
  '';

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 0;

  hardware.cpu.amd.updateMicrocode = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.disabledPlugins = [ "PowerManager" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ amdvlk ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  };

  powerManagement.enable = true;

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
        turbo = "always";
      };
    };
  };

  # environment.etc."pulse/client.conf".text = ''
  #   default-server = tcp:192.168.1.110
  # '';
}
