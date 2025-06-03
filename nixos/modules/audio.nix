{
  security.rtkit.enable = true;
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "rtprio";
      type = "soft";
      value = "95";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "hard";
      value = "95";
    }
    {
      domain = "@audio";
      item = "memlock";
      type = "soft";
      value = "8388608";
    }
    {
      domain = "@audio";
      item = "memlock";
      type = "hard";
      value = "8388608";
    }
  ];

  systemd.user.services."pipewire".serviceConfig = {
    LimitRTPRIO = 95;
    LimitMEMLOCK = "8M";
    CPUSchedulingPolicy = "rr";
    CPUSchedulingPriority = 89;
    wants = [ "rtkit-daemon.service" ];
    after = [ "rtkit-daemon.service" ];
  };

  systemd.user.services."pipewire-pulse".serviceConfig = {
    LimitRTPRIO = 95;
    LimitMEMLOCK = "8M";
    CPUSchedulingPolicy = "rr";
    CPUSchedulingPriority = 89;
    wants = [ "rtkit-daemon.service" ];
    after = [ "rtkit-daemon.service" ];
  };

  systemd.user.services."wireplumber".serviceConfig = {
    LimitRTPRIO = 95;
    LimitMEMLOCK = "8M";
    CPUSchedulingPolicy = "rr";
    CPUSchedulingPriority = 89;
    wants = [ "rtkit-daemon.service" ];
    after = [ "rtkit-daemon.service" ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 512;
        "default.clock.max-quantum" = 4096;
      };
    };

    extraConfig.pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "4096/48000";
            pulse.default.req = "1024/48000";
            pulse.max.req = "256/48000";
            pulse.min.quantum = "4096/48000";
            pulse.max.quantum = "4096/48000";
          };
        }
      ];
      stream.properties = {
        node.latency = "1024/48000";
        resample.quality = 3;
      };
    };
  };
}
