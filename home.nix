{ pkgs, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # basic
    bat
    helix
    ripgrep
    just
    eza
    devenv
    delta
    difftastic
    mergiraf
    zoxide
    rizin
    kalker
    cloudflared
    hyperfine
    tre-command
    ffmpeg

    # indirect
    starship

    # programming
    go
    # gcc
    # clang-tools
    nil
    uv
    typescript-language-server
    astro-language-server
    rustup
    coursier
    tflint
    pre-commit
    opentofu
    dbmate
    maven

    # GUI
    vscode
    mongodb-compass

    # virtualization
    podman
    podman-compose

    # etc.
    nerd-fonts.geist-mono

    # other tools
    google-cloud-sdk
    kafkactl
  ];

  home.file = {
    # ".zshrc".source = ./dotfiles/.zshrc;
    # ".config/helix/config.toml".source = ./dotfiles/.config/helix/config.toml;
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.bun/bin"
  ];

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      # zed = "zeditor";
      ls = "eza";
    };
  };

  programs.starship.enable = true;

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox-material";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  nix.package = null;

  programs.alacritty = {
    enable = true;
    theme = "gruvbox_material_medium_dark";
    settings = {
      terminal.shell = {
        program = "/etc/profiles/per-user/splinter/bin/zellij";
      };  
      window = {
        startup_mode = "Maximized";
        blur = true;
      };
      font = {
        normal.family = "GeistMono Nerd Font Mono";
        size = 14.0;
      };
      keyboard.bindings = [
        {
          key = "W";
          mods = "Command";
          action = "ReceiveChar";
        }
        {
          key = "T";
          mods = "Command";
          action = "ReceiveChar";
        }
        {
          key = "LBracket";
          mods = "Command";
          action = "ReceiveChar";
        }
        {
          key = "RBracket";
          mods = "Command";
          action = "ReceiveChar";
        }
      ];
    };
  };

  programs.zellij = {
    enable = true;
    settings = {
      theme = "gruvbox-dark";
      show_startup_tips = false;
    };
    extraConfig = ''
    keybinds {
      shared_except "locked" {
        bind "Super d" { NewPane "Right"; }
        bind "Super Shift d" { NewPane "Down"; }
        bind "Super Left"  { MoveFocus "Left"; }
        bind "Super Right" { MoveFocus "Right"; }
        bind "Super Up"    { MoveFocus "Up"; }
        bind "Super Down"  { MoveFocus "Down"; }
        bind "Super w" { CloseFocus; }
        bind "Super t" { NewTab; }
        bind "Super [" { GoToPreviousTab; }
        bind "Super ]" { GoToNextTab; }
      }
    }
    '';
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  programs.nushell = {
    enable = true;
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };
}
