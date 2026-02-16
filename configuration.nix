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
        brews = [
          "krakend"
        ];
        casks = [
          "ghostty"
          "obsidian"
          "maccy"
          "vlc"
        ];
      };

      nix.settings.experimental-features = "nix-command flakes";

      programs.zsh.enable = true;

      system.stateVersion = 5;

      nixpkgs.hostPlatform = "aarch64-darwin";

      nix.channel.enable = false;

      nixpkgs.config.allowUnfree = true;

      users.users.splinter = {
        name = "splinter";
        home = "/Users/splinter";
      };

      system.primaryUser = "splinter";

      # services.tailscale.enable = true;

      nix.settings.trusted-users = [
        "splinter"
      ];
    }
