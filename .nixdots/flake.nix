{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    catppuccin.url = "github:catppuccin/nix";
    qshell.url = "github:NemurenaiDev/qshell";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      host = { username = "nemurenai"; };
    in {
      nixosConfigurations.x14p = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system host; };
        modules = [
          ./nixos/hosts/x14p/configuration.nix

          inputs.home-manager.nixosModules.home-manager
          inputs.catppuccin.nixosModules.catppuccin
        ];
      };

      homeConfigurations."${host.username}" =
        inputs.home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs system host; };
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./home/home.nix ];
        };
    };
}
