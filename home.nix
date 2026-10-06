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
    zoxide
    rizin
    kalker
    cloudflared
    hyperfine
    tre-command
    ffmpeg
    miller
    bottom

    # indirect
    starship

    # programming
    go
    # gcc
    # clang-tools
    nil
    uv
    rustup
    tflint
    pre-commit
    opentofu
    dbmate

    # GUI
    vscode
    mongodb-compass

    # virtualization
    # podman
    # podman-compose
    # kind
    # kubectl
    # skaffold
    colima
    docker

    # etc.
    nerd-fonts.geist-mono

    # other tools
    google-cloud-sdk
    kafkactl

    # misc.
    typst
  ];

  home.file = {
    # ".zshrc".source = ./dotfiles/.zshrc;
    # ".config/helix/config.toml".source = ./dotfiles/.config/helix/config.toml;
  };

  home.sessionVariables = {
    EDITOR = "hx";
    LIBCLANG_PATH = "/Users/splinter/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-20.1.1_20250829/esp-clang/lib";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.bun/bin"
    "$HOME/.cargo/bin"
    "$HOME/.rustup/toolchains/esp/xtensa-esp-elf/esp-15.2.0_20250920/xtensa-esp-elf/bin"
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
