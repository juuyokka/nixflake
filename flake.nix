{
  description = "lactose's 🆕 and improved NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    systems.url = "github:nix-systems/default";

    disko = {
      url = "github:nix-community/disko?ref=f7424625dc1f2e4eceac3009cbd1203d566feebc";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = inputs:
    with inputs; let
      eachSystem = nixpkgs.lib.genAttrs (import systems);
      specialArgs = {inherit inputs self;};

      mkNixos = system: hostConfig:
        nixpkgs.lib.nixosSystem {
          inherit specialArgs system;
          modules = [
            disko.nixosModules.disko
            ./modules/nixos
            hostConfig
          ];
        };

      mkHome = system: homeConfig:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {inherit system;};
          extraSpecialArgs = specialArgs;
          modules = [
            ./modules/home
            homeConfig
          ];
        };
    in {
      nixosConfigurations = {
        "milk-jug" = mkNixos "x86_64-linux" ./hosts/milk-jug;
      };

      homeConfigurations = {
        "lactose@milk-jug" = mkHome "x86_64-linux" ./home/lactose/milk-jug.nix;
      };

      devShells = eachSystem (system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            disko.packages.${system}.default
            nixos-install-tools
            just
            nixpkgs-fmt
          ];

          shellHook = ''
          '';
        };
      });
    };
}
