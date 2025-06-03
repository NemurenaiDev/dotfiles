{ pkgs, lib, ... }:

{
  # environment.systemPackages = [ pkgs.easyeffects ];

  security.rtkit.enable = true;

  systemd.user.services.pipewire.serviceConfig = {
    CPUSchedulingPolicy = "fifo";
    CPUSchedulingPriority = 90;
    LimitRTPRIO = 95;
    LimitRTTIME = "infinity";
    Nice = -20;
  };

  systemd.user.services.pipewire-pulse.serviceConfig = {
    CPUSchedulingPolicy = "fifo";
    CPUSchedulingPriority = 90;
    LimitRTPRIO = 95;
    LimitRTTIME = "infinity";
    Nice = -20;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 256;
        "default.clock.max-quantum" = 4096;
      };
    };

    extraConfig.pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "1024/48000";
            pulse.default.req = "1024/48000";
            pulse.max.req = "1024/48000";
            pulse.min.quantum = "256/48000";
            pulse.max.quantum = "4096/48000";
          };
        }
      ];
      stream.properties = {
        node.latency = "1024/48000";
        resample.quality = 1;
      };
    };

    # extraConfig.pipewire."99-ignore-easyeffects" = {
    #   context.modules = [
    #     {
    #       name = lib.mkForce {
    #         args = {
    #           node.name = "easyeffects_sink";
    #           idle-timeout = 1;
    #         };
    #       };
    #     }
    #   ];
    # };
  };
}
