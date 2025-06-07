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
    qshell.url = "github:NemurenaiDev/qshell";
    musnix.url = "github:musnix/musnix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (nixpkgs.lib) listToAttrs;

      hosts = [
        {
          hostname = "cyberia";
          username = "nemurenai";
          timezone = "Europe/Kyiv";
          system = "x86_64-linux";
          stateVersion = "24.11";
          monitors = {
            central = "DP-1";
            left = "HDMI-A-1";
            config = [
              ", highres@highrr, 0x0, 1"
              "DP-1, 1920x1080@144, 0x0, 1"
              "HDMI-A-1, 1920x1080@144, -1920x0, 1"
              # "HDMI-A-1, 1920x1080@144, 0x0, 1, mirror, DP-1"
            ];
          };
        }
        {
          hostname = "x14p";
          username = "nemurenai";
          timezone = "Europe/Kyiv";
          system = "x86_64-linux";
          stateVersion = "24.11";
          monitors = {
            central = "eDP-1";
            config = [
              ", highres@highrr, 0x0, 1"
              "eDP-1, 2560x1600@60, 0x0, 1.6"
            ];
          };
        }
      ];

      nixosFor =
        host:
        nixpkgs.lib.nixosSystem {
          system = host.system;
          specialArgs = { inherit inputs host; };
          modules = [
            ./nixos/hosts/${host.hostname}/configuration.nix
            inputs.catppuccin.nixosModules.catppuccin
            inputs.musnix.nixosModules.musnix
          ];
        };

      homeFor =
        host:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${host.system};
          extraSpecialArgs = { inherit inputs host; };
          modules = [ ./home/home.nix ];
        };
    in
    {
      nixosConfigurations = listToAttrs (
        map (host: {
          name = host.hostname;
          value = nixosFor host;
        }) hosts
      );

      homeConfigurations = listToAttrs (
        map (host: {
          name = host.username;
          value = homeFor host;
        }) hosts
      );
    };
}
