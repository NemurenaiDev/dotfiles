{
  config,
  pkgs,
  lib,
  ...
}:

let
  run-code-project = pkgs.writeShellScriptBin "run-code-project" ''
    kitty --single-instance --class "kitty-project" sh -c \
        'code -n $(\
            find ~/Projects -mindepth 1 -maxdepth 1 \( -type d -o -type l \) | \
            grep -v .stfolder | \
            sed "s|$HOME|~|" | \
            sort -r | \
            fzf --ansi --preview-window border-left --preview "lsd --literal --icon always --color always --group-dirs first --date +%x\ %T \$(eval echo {})" | \
            sed "s|~|$HOME|g" \
        )' 
  '';
in
{
  xdg.desktopEntries.run-code-project = {
    name = "VSCode Project";
    comment = "Select and open project in VSCode";
    genericName = "Text Editor";
    exec = "${run-code-project}/bin/run-code-project";
    icon = "${config.xdg.dataHome}/assets/icons/vscode-folder.svg";
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
    icon = "${config.xdg.dataHome}/assets/icons/vscode.svg";
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
    icon = "${config.xdg.dataHome}/assets/icons/vscode.svg";
    startupNotify = true;
    type = "Application";
    noDisplay = true;
  };
}
