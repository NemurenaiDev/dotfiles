{ pkgs, ... }:

let
  scripts = {
    run-after-keyring = ''
      COLLECTION="/org/freedesktop/secrets/collection/login"

      if [ "$#" -lt 1 ]; then
          echo "Usage: $0 <command> [args...]"
          exit 1
      fi

      echo "Waiting for keyring unlock..."

      while true; do
          locked=$(
              ${pkgs.glib}/bin/gdbus call \
                  --session \
                  --dest org.freedesktop.secrets \
                  --object-path "$COLLECTION" \
                  --method org.freedesktop.DBus.Properties.Get \
                  org.freedesktop.Secret.Collection Locked \
              2>/dev/null \
              | ${pkgs.gnugrep}/bin/grep -oE 'true|false' \
              || true
          )

          if [ "$locked" = "false" ]; then
              break
          fi

          sleep 1
      done

      echo "Keyring unlocked, executing..."

      exec "$@"
    '';

    run-on-workspace = ''
      workspace_id="$1"
      command="$2"
      arg="$3"

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
          hyprctl dispatch exec "[workspace $workspace_id silent]" "$command" > /dev/null
      fi
    '';

    run-powermenu = ''kitty --single-instance --class "kitty-powermenu" sh -c "$XDG_DATA_HOME/bin/powermenu"'';

    run-sink-selector = ''kitty --single-instance --class "kitty-sink-selector" select-default-sink'';

    select-default-sink = ''
      pactl set-default-sink "$(pactl -f json list sinks | \
          jq -r --arg default "$(pactl get-default-sink)" '.[] | "\(.index) \(if .name == $default then "* " else "  " end)\(.name)"' | \
          awk '/alsa_output/ {a[++n]=$0; next} {print} END {for (i=1;i<=n;i++) print a[i]}' | \
          fzf | \
          grep -oP "\d+")"
    '';
  };
in
{
  home.packages = builtins.attrValues (
    builtins.mapAttrs (name: body: pkgs.writeShellScriptBin name body) scripts
  );
}
