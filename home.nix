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
    colima
    kubectl

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
    "$HOME/.cargo/bin"
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
    initContent = ''
      if [ -f /etc/nix-darwin/.env ]; then
        set -a
        source /etc/nix-darwin/.env
        set +a
      fi
    '';
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
        option_as_alt = "OnlyLeft";
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
        {
          key = "Back";
          mods = "Alt";
          chars = "\\u001b\\u007f";
        }
        {
          key = "Back";
          mods = "Command";
          chars = "\\u0015";
        }
        {
          key = "Left";
          mods = "Alt";
          chars = "\\u001bb";
        }
        {
          key = "Right";
          mods = "Alt";
          chars = "\\u001bf";
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
        unbind "Alt Left"
        unbind "Alt Right"
        unbind "Alt Up"
        unbind "Alt Down"
        unbind "Alt f"
        unbind "Alt b"
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
    shellWrapperName = "y";
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
