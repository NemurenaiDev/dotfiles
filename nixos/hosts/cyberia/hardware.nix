{
  lib,
  host,
  config,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0a99facb-d95a-4a4c-9251-8909761c09f2";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FAA5-284B";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  # TODO: drop archlinux and make use of this drive (move nixos here?)
  # fileSystems."/mnt/archlinux" = {
  #   device = "UUID=0d8e7100-8c32-4446-9404-ecf67d77288b";
  #   fsType = "ext4";
  #   options = [
  #     "nofail"
  #     "x-systemd.automount"
  #   ];
  # };

  fileSystems."/home/${host.username}/Library" = {
    device = "UUID=c6bae1c8-fe05-4353-8267-e63053a7c8f6";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.automount"
    ];
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
