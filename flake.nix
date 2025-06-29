{
  description = "Rafky's Amartha Nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, mac-app-util, ... }:
  let
    revisionCfg = { pkgs, ... }: {
      system.configurationRevision = self.rev or self.dirtyRev or null;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#NB-MuhammadRafky-Tech
    darwinConfigurations."NB-MuhammadRafky-Tech" = nix-darwin.lib.darwinSystem {
      modules = [
        revisionCfg
        ./configuration.nix
        mac-app-util.darwinModules.default
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.splinter = { pkgs, lib, ... }: {
            imports = [
              ./home.nix
              mac-app-util.homeManagerModules.default
            ];
          };
        }
      ];
    };
  };
}
