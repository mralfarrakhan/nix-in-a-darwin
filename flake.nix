{
  description = "Rafky's Amartha Nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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

  outputs = { self, nix-darwin, home-manager, mac-app-util, nix-homebrew, homebrew-core, homebrew-cask, determinate, ... }:
  let
    revisionCfg = { ... }: {
      system.configurationRevision = self.rev or self.dirtyRev or null;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#NB-MuhammadRafky-Tech
    darwinConfigurations."servo-0" = nix-darwin.lib.darwinSystem {
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
            enable = true;
            enableRosetta = true;
            user = "splinter";
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
            };
            mutableTaps = false;
          };
        }
        determinate.darwinModules.default
        {
          determinateNix = {
            enable = true;
            customSettings = {
              eval-cores = 0;
              trusted-users = [ "splinter" ];
              extra-experimental-features = [ "build-time-fetch-tree" ];
            };
          };
        }
      ];
    };
  };
}
