workspace_id="$1"
command="$2"

hyprctl dispatch workspace $workspace_id

WorkspaceLastWindow=$(hyprctl -j workspaces | jq --arg id "$workspace_id" '.[] | select(.id == ($id|tonumber)) | .lastwindowtitle')

if [[ $WorkspaceLastWindow == "\"\"" ]]; then
    eval "$command"
fi