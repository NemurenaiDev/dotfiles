{ config, pkgs, ... }:

let
  run-on-workspace = pkgs.writeShellScriptBin "run-on-workspace" ''
    workspace_id="$1"
    command="$2"
    arg="$3"

    if [[ $arg == "--run-anyway" ]]; then
        ActiveWorkspace=$(hyprctl -j activeworkspace | jq '.id')
        if [ "$ActiveWorkspace" == "$workspace_id" ]; then
            hyprctl dispatch exec [workspace "$workspace_id" silent] "$command" > /dev/null
        else
            if [[ "$workspace_id" == "special"* ]]; then
                IFS=":" read -r workspace special_workspace_name <<<"$workspace_id"
                hyprctl dispatch togglespecialworkspace "$special_workspace_name" > /dev/null
            else
                hyprctl dispatch workspace "$workspace_id" > /dev/null
            fi
        fi
    else
        if [[ -z $arg ]]; then
            if [[ "$workspace_id" == "special"* ]]; then
                IFS=":" read -r workspace special_workspace_name <<<"$workspace_id"
                hyprctl dispatch togglespecialworkspace "$special_workspace_name" > /dev/null
            else
                hyprctl dispatch workspace "$workspace_id" > /dev/null
            fi
        fi

        WorkspaceLastWindow=$(hyprctl -j workspaces | jq --arg name "$workspace_id" '.[] | select(.name == ($name|tostring)) | .lastwindowtitle')
        WorkspaceLastWindow="''${WorkspaceLastWindow//\"/}"

        if [[ -z $WorkspaceLastWindow ]]; then
            hyprctl dispatch exec [workspace "$workspace_id" silent] "$command" > /dev/null
        fi
    fi
  '';
  run = "${run-on-workspace}/bin/run-on-workspace";

  scripts = {
    select-default-sink = ''pactl set-default-sink "$(pactl -f json list sinks | jq -r --arg default "$(pactl get-default-sink)" '.[] | "\(.index) \(if .name == $default then "* " else "  " end)\(.name)"' | fzf | grep -oP "\d+")"'';

    run-sink-selector = ''kitty --class "kitty-sink-selector" select-default-sink'';

    run-powermenu = ''kitty --class "kitty-powermenu" sh -c "~/.bin/powermenu"'';
    run-code-project = ''
      kitty --class "kitty-project" sh -c \
          'code -n $(\
              find ~/Projects -mindepth 1 -maxdepth 1 \( -type d -o -type l \) | \
              sed "s|$HOME|~|" | \
              sort -r | \
              fzf --ansi --preview-window border-left --preview "lsd --literal --icon always --color always --group-dirs first --date +%x\ %T \$(eval echo {})" | \
              sed "s|~|$HOME|g" \
          )' 
    '';

    # run-aichat = ''${run} "special:aichat" "chromium --app=https://chatgpt.com/" "$1"'';
    # run-aichat = ''${run} "special:aichat" "chromium --app=https://claude.ai/new" "$1"'';
    run-aichat = ''${run} "special:aichat" "chromium --app=https://gemini.google.com/" "$1"'';

    run-explorer = ''[[ "$1" == "--just-run" ]] && nemo || ${run} "13" "nemo" "$1"'';
    run-task-manager = ''${run} "15" "kitty --single-instance btop" "$1"'';
    run-browser = ''${run} "21" "zen --profile ${config.home.homeDirectory}/.zen/x6xuobo4.nemurenai" "$@"'';
    run-browser-incognito = ''${run} "22" "zen --profile ${config.home.homeDirectory}/.zen/x6xuobo4.nemurenai --private-window" "$1"'';
    run-telegram = ''${run} "25" "Telegram" "$1"'';
    run-discord = ''${run} "26" "vesktop" "$1"'';
    run-spotify = ''${run} "36" "spotify --enable-features=UseOzonePlatform --ozone-platform-hint=wayland" "$1"'';
    run-obs = ''${run} "39" "obs" "$1"'';
  };
in
{
  home.packages = builtins.attrValues (
    builtins.mapAttrs (name: body: pkgs.writeShellScriptBin name body) scripts
  );
}
