{ config, ... }:

{
  imports = [
    ./browser.nix
    ./project.nix
  ];

  home.activation."link-desktop-to-applications" = ''
    mkdir -p ${config.home.homeDirectory}/Desktop
    mkdir -p ${config.home.homeDirectory}/.local/share/applications

    rm -f ${config.home.homeDirectory}/.local/share/applications/Desktop

    ln -sf ${config.home.homeDirectory}/Desktop ${config.home.homeDirectory}/.local/share/applications/Desktop
  '';
}
