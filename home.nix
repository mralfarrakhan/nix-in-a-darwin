{ pkgs, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # basic
    bat
    helix
    ripgrep
    just
    zellij
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

    # indirect
    starship

    # programming
    go
    # gcc
    # clang-tools
    nil
    uv
    bun
    typescript-language-server
    astro-language-server
    rustup
    coursier
    tflint
    pre-commit
    opentofu
    dbmate

    # GUI
    vscode
    postman
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
  };

  nix.package = null;
}
