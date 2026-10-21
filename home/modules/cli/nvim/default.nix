{ pkgs, ... }:

{
  xdg.configFile."nvim/lua".source = ./lua;

  programs.neovim = {
    enable = true;

    withNodeJs = false;
    withPerl = false;
    withPython3 = false;
    withRuby = false;

    waylandSupport = true;

    initLua = ''
      require("config.lazy")
    '';
  };

  programs.neovim.plugins = with pkgs.vimPlugins; [
    lazy-nvim
    LazyVim
  ];

  home.packages = with pkgs; [
    tree-sitter
  ];
}
