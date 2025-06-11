{
  boot.kernelModules = [ "snd-aloop" ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 256;
        "default.clock.min-quantum" = 256;
        "default.clock.max-quantum" = 2048;
      };
    };

    extraConfig.pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.default.req = "256/48000";
            pulse.min.req = "256/48000";
            pulse.max.req = "2048/48000";
            pulse.min.quantum = "2048/48000";
            pulse.max.quantum = "2048/48000";
          };
        }
      ];
      stream.properties = {
        node.latency = "256/48000";
        resample.quality = 3;
      };
    };
  };
}
