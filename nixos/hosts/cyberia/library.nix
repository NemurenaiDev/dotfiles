{ host, ... }:

{
  fileSystems."/home/${host.username}/Library/Drive1" = {
    device = "UUID=9e553369-3157-4c1a-ab7a-fa9d2d08c9a5";
    fsType = "ext4";
    options = [
      "nofail"
      "noatime"
      "defaults"
      "x-systemd.automount"
    ];
  };

  fileSystems."/home/${host.username}/Library/Drive2" = {
    device = "UUID=c6bae1c8-fe05-4353-8267-e63053a7c8f6";
    fsType = "ext4";
    options = [
      "nofail"
      "noatime"
      "defaults"
      "x-systemd.automount"
    ];
  };
}
