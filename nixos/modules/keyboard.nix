{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.keyd
    pkgs.vial
  ];

  hardware.keyboard.qmk.enable = true;

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0c45", ATTRS{idProduct}=="8033", MODE="0660", TAG+="uaccess"
  '';

  services.keyd = {
    enable = true;

    keyboards = {

      # default = {
      #   ids = [ "*" ];

      #   settings = {
      #     main = {
      #       capslock = "menu";
      #     };
      #   };
      # };

      ak820max = {
        ids = [ "0c45:8033" ];

        settings = {
          main = {
            config = "layer(fn)";

            capslock = "menu";
          };

          fn = {
            f1 = "f13";
            f2 = "f14";
            f3 = "f15";
            f4 = "f16";

            f5 = "f17";
            f6 = "f18";
            f7 = "f19";
            f8 = "f20";

            f9 = "micmute";
            f10 = "previoussong";
            f11 = "playpause";
            f12 = "nextsong";

            pageup = "brightnessup";
            pagedown = "brightnessdown";
          };
        };
      };
    };
  };
}
