{
  xdg.configFile."docker/config.json".force = true;
  xdg.configFile."docker/config.json".text = ''
    {
      "psFormat": "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"
    }
  '';
}
