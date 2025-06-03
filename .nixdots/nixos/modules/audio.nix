{
  programs.noisetorch.enable = true;

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
  };

  systemd.user.services."pipewire-pulse".serviceConfig = {
    LimitRTPRIO = 95;
    LimitMEMLOCK = "8M";
    CPUSchedulingPolicy = "rr";
    CPUSchedulingPriority = 89;
  };

  systemd.user.services."wireplumber".serviceConfig = {
    LimitRTPRIO = 95;
    LimitMEMLOCK = "8M";
    CPUSchedulingPolicy = "rr";
    CPUSchedulingPriority = 89;
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
        "default.clock.quantum" = 128;
        "default.clock.min-quantum" = 64;
        "default.clock.max-quantum" = 512;
      };
    };

    extraConfig.pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "64/48000";
            pulse.default.req = "128/48000";
            pulse.max.req = "256/48000";
            pulse.min.quantum = "64/48000";
            pulse.max.quantum = "512/48000";
          };
        }
      ];
      stream.properties = {
        node.latency = "128/48000";
        resample.quality = 3;
      };
    };

  };
}
