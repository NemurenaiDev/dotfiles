{
  xdg.configFile."starship.toml".force = true;
  xdg.configFile."starship.toml".text = ''
    continuation_prompt = "[❯❯](magenta)"
    right_format = "$cmd_duration"
    format = "$directory $hostname$direnv$env_var$character"


    [cmd_duration]
    min_time = 5000
    format = "[$duration]($style)"
    style = "yellow"


    [hostname]
    ssh_only = false
    detect_env_vars = ['SSH_CONNECTION']
    format = "[$hostname ](bold red)"

    [direnv]
    format = "[$symbol](bright-black)[$loaded](bold yellow) "
    symbol = "direnv "
    disabled = false

    [env_var.USEPKGS]
    variable = 'USEPKGS'
    format = "[use](bright-black)[$env_value ](bold yellow)"


    [character]
    success_symbol = "[❯](magenta)"
    error_symbol = "[❯](red)"

    [directory]
    style = "blue"
    format = "[$path]($style)"
    truncation_length = 0
    truncate_to_repo = true
    fish_style_pwd_dir_length = 4
  '';
}
