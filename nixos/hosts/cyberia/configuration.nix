{ pkgs, ... }:

{
  imports = [
    ./../../default.configuration.nix
    ./hardware.nix
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.blacklistedKernelModules = [ "hid_uclogic" ];
  boot.kernelParams = [ "rtc_cmos.use_acpi_alarm=1" ];
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0 power_save_controller=N
    options snd_hda_intel enable_msi=1
  '';

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 0;

  hardware.cpu.amd.updateMicrocode = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.disabledPlugins = [ "PowerManager" ];

  hardware.firmware = [ pkgs.linux-firmware ];

  hardware.opentabletdriver.enable = true;

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

  services.system76-scheduler.enable = true;
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

  boot.kernelModules = [ "i2c-dev" ];
  hardware.i2c.enable = true;
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    package = pkgs.openrgb-with-all-plugins;
  };

  networking.interfaces.enp42s0.wakeOnLan.enable = true;
}
