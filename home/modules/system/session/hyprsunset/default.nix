{
  services.hyprsunset = {
    enable = true;
    settings = {
      profile = [
        {
          time = "10:00";
          identity = true;
        }
        {
          time = "18:00";
          temperature = 5500;
          gamma = 1;
        }
        {
          time = "20:00";
          temperature = 5000;
          gamma = 1;
        }
      ];
    };
  };
}
