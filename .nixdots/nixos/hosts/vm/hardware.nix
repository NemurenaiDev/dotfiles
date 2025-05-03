{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  time.timeZone = "Europe/Kyiv";

  networking.hostName = "vm";

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];


  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a9f8f9ec-8876-4a16-b984-a3bf3c8cbce6";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E3A7-A68E";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };


  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
