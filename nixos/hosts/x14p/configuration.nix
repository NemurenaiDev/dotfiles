{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];

  boot.kernelParams = [
    "idle=nomwait"
    "rcu_nocbs=0-15"
    "amd_pstate=active"
    "rtc_cmos.use_acpi_alarm=1"
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "keep";
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
