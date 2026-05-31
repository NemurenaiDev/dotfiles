{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    ancient.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-26.05";

    catppuccin.url = "github:catppuccin/nix";

    wayle.url = "github:wayle-rs/wayle";
    wayle.flake = false;

    wallpapers.url = "github:nemurenaidev/wallpapers";
    wallpapers.flake = false;
  };

  outputs =
    { ... }@inputs:
    let
      commonHostFields = {
        username = "nemurenai";
        hostname = "<DEVICE-HOSTNAME>";
        deviceId = "<SYNKTHING-DEVICE-ID>";
        snapclients = [ ];
        timezone = "Europe/Kyiv";
        system = "x86_64-linux";
        stateVersion = "24.11";
      };

      hostsRaw = [
        {
          hostname = "homelab";
          deviceId = "Y33IVUJ-5HMEGX6-CLW3PAQ-PXKI2RF-TUM3Y7C-VAQTDE7-V43LW4V-RV7TIAD";
          roles = [
            "server"
            "immich"
            "hassistant"
          ];
          snapclients = [
            "127.0.0.1"
            "192.168.1.110"
            "192.168.1.111"
          ];
        }
        {
          hostname = "cyberia";
          deviceId = "LZAWUPK-DVPWCJ5-7INP5UI-ULGJYSM-25VYXL6-CCHYYXG-A5YFA4O-PORVFAO";
          roles = [
            "desktop"
            "gamehost"
          ];
          snapserver = {
            buffer = 300;
            codec = "flac";
          };
          snapclients = [
            "127.0.0.1"
            "192.168.1.101"
            "192.168.1.111"
          ];
        }
        {
          hostname = "x14p";
          deviceId = "VZHX56X-H3U2APW-3E7QETV-3NR6QCV-7JTOVFF-FAY3E5B-DNY3HHH-RATQEAW";
          roles = [
            "laptop"
            "desktop"
            "gameclient"
          ];
          snapserver = {
            buffer = 400;
            codec = "flac";
          };
        }
      ];

      hosts = map (host: inputs.nixpkgs.lib.recursiveUpdate commonHostFields host) hostsRaw;

      basepkgs = {
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = [
          (final: prev: {
            wayle = prev.rustPlatform.buildRustPackage {
              meta = prev.wayle.meta;
              pname = prev.wayle.pname;
              version = "git-${inputs.wayle.lastModifiedDate}";

              doCheck = false;

              src = inputs.wayle;

              cargoHash = "sha256-4PUXJwUP5h/ggZQbY78BdqMh5oZes1XCeWuT2/S94Z4=";

              desktopItems = prev.wayle.desktopItems;

              nativeBuildInputs = prev.wayle.nativeBuildInputs;
              buildInputs = prev.wayle.buildInputs;

              cargoBuildFlags = prev.wayle.cargoBuildFlags;

              preCheck = prev.wayle.preCheck;
              preInstall = prev.wayle.preInstall;
              postInstall = prev.wayle.postInstall;
              preFixup = prev.wayle.preFixup;
            };
          })

          (final: prev: {
            previous = import inputs.previous {
              overlays = prev.overlays;
              system = prev.stdenv.hostPlatform.system;
              config.allowUnfree = prev.config.allowUnfree;
            };
            ancient = import inputs.ancient {
              overlays = prev.overlays;
              system = prev.stdenv.hostPlatform.system;
              config.allowUnfree = prev.config.allowUnfree;
            };
            unstable = import inputs.unstable {
              overlays = prev.overlays;
              system = prev.stdenv.hostPlatform.system;
              config.allowUnfree = prev.config.allowUnfree;
            };
          })
        ];
      };

      nixosFor =
        host:
        inputs.nixpkgs.lib.nixosSystem {
          system = host.system;
          specialArgs = {
            inherit inputs hosts host;
            hasRole = role: builtins.elem role host.roles;
          };
          modules = [ basepkgs ] ++ [ ./nixos/default.configuration.nix ];
        };

      homeFor =
        host:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs { system = host.system; };
          extraSpecialArgs = {
            inherit inputs hosts host;
            hasRole = role: builtins.elem role host.roles;
          };
          modules = [ basepkgs ] ++ [ ./home/default.home.nix ];
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
