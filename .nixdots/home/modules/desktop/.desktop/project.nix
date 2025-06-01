{ config, ... }:

{
  xdg = {
    desktopEntries = {
      run-code-project = {
        name = "VSCode Project";
        comment = "Select and open project in VSCode";
        genericName = "Text Editor";
        exec = "${config.home.homeDirectory}/.nix-profile/bin/run-code-project";
        icon = "${config.home.homeDirectory}/.assets/icons/vscode-folder.svg";
        type = "Application";
        startupNotify = false;
        categories = [
          "TextEditor"
          "Development"
          "IDE"
        ];
        mimeType = [
          "text/plain"
          "inode/directory"
          "application/x-code-workspace"
        ];
      };
    };
  };
}
