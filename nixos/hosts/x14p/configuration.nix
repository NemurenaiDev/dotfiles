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

  services.tlp = {
    enable = true;
    pd.enable = true;

    settings = {
      TLP_AUTO_SWITCH = 2;

      CPU_BOOST_ON_AC = 1;
      # limit max cpu freq so it wont fry with active turbo (3750000 equals to 3.75 GHz)
      # note: this value goes into /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
      CPU_SCALING_MAX_FREQ_ON_AC = 3750000;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";

      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      CPU_BOOST_ON_SAV = 0;
      CPU_SCALING_GOVERNOR_ON_SAV = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_SAV = "power";
    };
  };
}
