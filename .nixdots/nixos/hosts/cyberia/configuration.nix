{ pkgs, ... }:

{
  imports = [
    ./../../default.configuration.nix
    ./hardware.nix
    ./snapcast.nix
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "rtc_cmos.use_acpi_alarm=1" ];
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
    options amdgpu dpm=1
  '';

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 0;

  hardware.cpu.amd.updateMicrocode = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.disabledPlugins = [ "PowerManager" ];

  hardware.firmware = [ pkgs.linux-firmware ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ amdvlk ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    mesa
    vulkan-loader
    vulkan-tools
  ];

  powerManagement.enable = true;

  services.system76-scheduler.settings.cfsProfiles.enable = true;

  services.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "always";
      };
    };
  };
}
