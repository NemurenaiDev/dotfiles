{ config, ... }:

{
  imports = [ ./project.nix ];

  home.activation.linkDesktopToApplications = ''
    mkdir -p ${config.home.homeDirectory}/Desktop
    mkdir -p ${config.home.homeDirectory}/.local/share/applications

    ln -s ${config.home.homeDirectory}/Desktop ${config.home.homeDirectory}/.local/share/applications/Desktop
  '';
}
