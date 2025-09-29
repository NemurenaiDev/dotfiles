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
      commonHostFields = {
        hostname = "<DEVICE-HOSTNAME>";
        username = "nemurenai";
        deviceId = "<SYNKTHING-DEVICE-ID>";
        snapclients = [ ];
        timezone = "Europe/Kyiv";
        system = "x86_64-linux";
        stateVersion = "24.11";
      };

      hostsRaw = [
        {
          hostname = "cyberia";
          deviceId = "LZAWUPK-DVPWCJ5-7INP5UI-ULGJYSM-25VYXL6-CCHYYXG-A5YFA4O-PORVFAO";
          roles = [ "desktop" ];
          snapserver = {
            buffer = 400;
            codec = "flac";
          };
          snapclients = [
            "127.0.0.1"
            "192.168.1.111"
          ];
        }
        {
          hostname = "x14p";
          deviceId = "VZHX56X-H3U2APW-3E7QETV-3NR6QCV-7JTOVFF-FAY3E5B-DNY3HHH-RATQEAW";
          roles = [ "desktop" ];
          snapserver = {
            buffer = 400;
            codec = "flac";
          };
        }
        {
          hostname = "homelab";
          deviceId = "Y33IVUJ-5HMEGX6-CLW3PAQ-PXKI2RF-TUM3Y7C-VAQTDE7-V43LW4V-RV7TIAD";
          roles = [ "server" ];
          snapclients = [
            "192.168.1.110"
            "192.168.1.111"
          ];
        }
      ];

      hosts = map (host: inputs.nixpkgs.lib.recursiveUpdate commonHostFields host) hostsRaw;

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
