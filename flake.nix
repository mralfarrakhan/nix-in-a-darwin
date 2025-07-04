{
  description = "Rafky's Amartha Nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
        url = "github:homebrew/homebrew-core";
        flake = false;
    };

    homebrew-cask = {
        url = "github:homebrew/homebrew-cask";
        flake = false;
    };

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = { self, nix-darwin,  home-manager, mac-app-util, nix-homebrew, homebrew-core, homebrew-cask,... }:
  let
    revisionCfg = { ... }: {
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
          home-manager.users.splinter = { ... }: {
            imports = [
              ./home.nix
              mac-app-util.homeManagerModules.default
            ];
          };
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
            nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "splinter";

            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
            };

            # Optional: Enable fully-declarative tap management
            #
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = false;
          };
        }
      ];
    };
  };
}
