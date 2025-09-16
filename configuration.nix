{ pkgs, ... }:

{
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =  with pkgs; [
        vim
        git
        wget
      ];

      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";
        taps = [];
        brews = [];
        casks = [ "ghostty" ];
      };

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

      nix.channel.enable = false;

      nixpkgs.config.allowUnfree = true;

      users.users.splinter = {
        name = "splinter";
        home = "/Users/splinter";
      };

      system.primaryUser = "splinter";

      services.tailscale.enable = true;

      nix.settings.trusted-users = [
        "splinter"
      ];
    }
