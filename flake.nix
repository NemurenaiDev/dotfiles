{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:youwen5/zen-browser-flake";
    catppuccin.url = "github:catppuccin/nix";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    { ... }@inputs:
    let
      hosts = [
        {
          hostname = "cyberia";
          username = "nemurenai";
          timezone = "Europe/Kyiv";
          system = "x86_64-linux";
          stateVersion = "24.11";
          roles = [ "desktop" ];
          snapserver = {
            buffer = 200;
            codec = "pcm";
          };
        }
        {
          hostname = "x14p";
          username = "nemurenai";
          timezone = "Europe/Kyiv";
          system = "x86_64-linux";
          stateVersion = "24.11";
          roles = [ "desktop" ];
          snapserver = {
            buffer = 400;
            codec = "flac";
          };
        }
        {
          hostname = "homelab";
          username = "nemurenai";
          timezone = "Europe/Kyiv";
          system = "x86_64-linux";
          stateVersion = "24.11";
          roles = [ "server" ];
        }
      ];

      nixosFor =
        host:
        inputs.nixpkgs.lib.nixosSystem {
          system = host.system;
          specialArgs = {
            inherit inputs host;
            hasRole = role: builtins.elem role host.roles;
          };
          modules = [ ./nixos/hosts/${host.hostname}/configuration.nix ];
        };

      homeFor =
        host:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.${host.system};
          extraSpecialArgs = {
            inherit inputs host;
            hasRole = role: builtins.elem role host.roles;
          };
          modules = [ ./home/hosts/${host.hostname}/home.nix ];
        };

      makeConfigurations =
        nameFn: valueFn:
        builtins.listToAttrs (
          map (host: {
            name = nameFn host;
            value = valueFn host;
          }) hosts
        );
    in
    {
      nixosConfigurations = makeConfigurations (host: host.hostname) nixosFor;
      homeConfigurations = makeConfigurations (host: "${host.username}@${host.hostname}") homeFor;
    };
}
