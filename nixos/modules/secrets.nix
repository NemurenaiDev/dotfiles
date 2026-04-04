{ inputs, host, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ./../../.sops.secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${host.username}/.config/sops/age/keys.txt";
    secrets = { };
  };
}