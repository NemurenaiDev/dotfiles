{ inputs, host, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ./../../secrets/secrets.yaml;
    age.keyFile = "/home/${host.username}/.config/sops/age/keys.txt";
    secrets = {
      "meow" = { };
    };
  };
}
