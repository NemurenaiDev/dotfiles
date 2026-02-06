{
  xdg.configFile."starship.toml".force = true;
  xdg.configFile."starship.toml".text = ''
    continuation_prompt = "[❯❯](magenta)"
    right_format = "$cmd_duration"
    format = "$directory $hostname$character"

    [cmd_duration]
    min_time = 5000
    format = "[$duration]($style)"
    style = "yellow"

    [hostname]
    ssh_only = false
    detect_env_vars = ['SSH_CONNECTION', 'BWRAP']
    format = "[$hostname ](bold red)"

    [character]
    success_symbol = "[❯](magenta)"
    error_symbol = "[❯](red)"

    [directory]
    style = "blue"
    format = "[$path]($style)"
    truncate_to_repo = false
    truncation_length = 0
  '';
}
