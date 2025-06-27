{
  description = "Rafky's Amartha Nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, lib, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =  with pkgs; [
        vim
        helix
        bat
        git
        go
      ];

      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";
        taps = [];
        brews = [];
        casks = [];
      };

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "GeistMono" ]; })
      ];
      
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "vscode"
      ];

      nix.channel.enable = false;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#NB-MuhammadRafky-Tech
    darwinConfigurations."NB-MuhammadRafky-Tech" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
