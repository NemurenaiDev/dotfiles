{ inputs, host, ... }:

{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    defaultSopsFile = ./../../../.sops.secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${host.username}/.config/sops/age/key.txt";
    secrets = { };
  };
}
