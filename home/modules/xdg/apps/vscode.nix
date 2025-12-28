{ host, lib, ... }:

{
  xdg.desktopEntries.run-code-project = {
    name = "VSCode Project";
    comment = "Select and open project in VSCode";
    genericName = "Text Editor";
    exec = "/home/${host.username}/.nix-profile/bin/run-code-project";
    icon = "/home/${host.username}/.assets/icons/vscode-folder.svg";
    type = "Application";
    startupNotify = false;
    categories = [
      "TextEditor"
      "Development"
      "IDE"
    ];
  };

  xdg.desktopEntries.code = lib.mkForce {
    name = "VSCode";
    comment = "Code Editing. Redefined.";
    genericName = "Text Editor";
    exec = "code --new-window %F";
    icon = "/home/${host.username}/.assets/icons/vscode.svg";
    startupNotify = true;
    type = "Application";
    categories = [
      "Utility"
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

  xdg.desktopEntries.code-url-handler = lib.mkForce {
    name = "VSCode Url Handler";
    exec = "code --new-window %F";
    icon = "/home/${host.username}/.assets/icons/vscode.svg";
    startupNotify = true;
    type = "Application";
    noDisplay = true;
  };
}
