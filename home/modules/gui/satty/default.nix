{
  programs.satty = {
    enable = true;

    settings = {
      general = {
        fullscreen = true;

        disable-notifications = true;

        initial-tool = "brush";
        copy-command = "wl-copy";

        actions-on-enter = [
          "save-to-clipboard"
          "exit"
        ];
        actions-on-escape = [
          "save-to-clipboard"
          "exit"
        ];
      };

      color-palette = {
        palette = [
          "#ea2739"
          "#fc964d"
          "#fcde65"
          "#80c864"
          "#49c5ed"
          "#3051e3"
          "#db3ad2"
          "#ff72a9"
        ];
      };
    };
  };
}
