{
  home.file.".docker/config.json".force = true;
  home.file.".docker/config.json".text = ''
    {
      "psFormat": "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"
    }
  '';
}
