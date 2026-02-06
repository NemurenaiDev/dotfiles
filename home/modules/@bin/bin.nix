{ pkgs, ... }:

let
  scripts = {
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

    vc-mount = ''sudo veracrypt --text --mount "$XDG_DATA_HOME/crypt.img" --protect-hidden=no --keyfiles=""'';

    vc-unmount = ''
      if ! veracrypt --text --list &>/dev/null; then
      	echo "No volumes to unmount. Exiting..."
      	exit 0
      fi

      get_mount_paths() {
      	veracrypt --text --list --verbose | grep "Mount Directory" | grep -Eo "/.+"
      }

      mapfile -t mounts < <(get_mount_paths)
      for mount in "''${mounts[@]}"; do
      	echo "Killing processes for $mount..."

      	mapfile -t pids < <(lsof -t "$mount")
      	for pid in "''${pids[@]}"; do
      		kill -TERM $pid
      	done
      	sleep 1

      	mapfile -t pids < <(lsof -t "$mount")
      	for pid in "''${pids[@]}"; do
      		kill -KILL $pid
      	done
      	sleep 0.1
      done

      echo "Unmounting volumes..."

      sudo --non-interactive veracrypt --text --unmount

      sleep 0.1

      if veracrypt --text --list &>/dev/null; then
      	echo "CRITICAL: Veracrypt volume still exists after unmounting"
      	notify-send -u critical "Veracrypt volume still exists after unmounting"
      	paplay --volume 65536 $XDG_DATA_HOME/assets/audio/error-010.mp3
      	exit 1
      else
      	paplay --volume 65536 $XDG_DATA_HOME/assets/audio/beep.mp3
      fi
    '';
  };
in
{
  home.packages = builtins.attrValues (
    builtins.mapAttrs (name: body: pkgs.writeShellScriptBin name body) scripts
  );
}
