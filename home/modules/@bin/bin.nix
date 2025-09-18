{ pkgs, ... }:

let
  scripts = {
    select-default-sink = ''pactl set-default-sink "$(pactl -f json list sinks | jq -r --arg default "$(pactl get-default-sink)" '.[] | "\(.index) \(if .name == $default then "* " else "  " end)\(.name)"' | awk '/alsa_output/ {a[++n]=$0; next} {print} END {for (i=1;i<=n;i++) print a[i]}' | fzf | grep -oP "\d+")"'';
  };
in
{
  home.packages = builtins.attrValues (
    builtins.mapAttrs (name: body: pkgs.writeShellScriptBin name body) scripts
  );
}
