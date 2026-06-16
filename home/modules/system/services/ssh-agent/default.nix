{
  home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";

  services.ssh-agent.enable = true;
}
