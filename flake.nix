{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

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
          deviceId = "LZAWUPK-DVPWCJ5-7INP5UI-ULGJYSM-25VYXL6-CCHYYXG-A5YFA4O-PORVFAO";
          dotfiles = "/home/nemurenai/Projects/dotfiles";
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
          hostname = "x14p";
          username = "nemurenai";
          deviceId = "VZHX56X-H3U2APW-3E7QETV-3NR6QCV-7JTOVFF-FAY3E5B-DNY3HHH-RATQEAW";
          dotfiles = "/home/nemurenai/Projects/dotfiles";
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
          deviceId = "Y33IVUJ-5HMEGX6-CLW3PAQ-PXKI2RF-TUM3Y7C-VAQTDE7-V43LW4V-RV7TIAD";
          dotfiles = "/home/nemurenai/Projects/dotfiles";
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
            inherit inputs hosts host;
            hasRole = role: builtins.elem role host.roles;
          };
          modules = [ ./nixos/hosts/${host.hostname}/configuration.nix ];
        };

      homeFor =
        host:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.${host.system};
          extraSpecialArgs = {
            inherit inputs hosts host;
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
