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
          temperature = 5000;
          gamma = 1;
        }
      ];
    };
  };
}
