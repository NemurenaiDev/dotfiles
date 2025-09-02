{ pkgs, ... }:

{
  imports = [
    ./../../default.configuration.nix
    ./hardware.nix
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "rtc_cmos.use_acpi_alarm=1" ];
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0 power_save_controller=N
    options snd_hda_intel enable_msi=1
  '';

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.timeout = 0;

  hardware.cpu.amd.updateMicrocode = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.disabledPlugins = [ "PowerManager" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ mesa ];
    extraPackages32 = with pkgs; [ driversi686Linux.mesa ];
  };

  environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-tools
  ];

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
}
