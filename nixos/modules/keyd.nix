{
  services.keyd = {
    enable = true;
    keyboards = {

      ak820max = {
        ids = [ "0c45:8033" ];
        settings.main = {
          # config = "f13";
          # volumedown = "f14";
          # volumeup = "f15";
          # mute = "f16";

          # stopcd = "f17";
          # previoussong = "f18";
          # playpause = "f19";
          # nextsong = "f20";

          mail = "f21";
          homepage = "f22";
          file = "f23";
          calc = "f24";
        };
      };

    };
  };
}
