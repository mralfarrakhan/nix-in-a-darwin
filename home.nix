{ pkgs, ... }:

{
  home.stateVersion = "25.05";

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

    # indirect
    starship

    # programming
    go
    gcc
    clang-tools
    nil
    uv
    gopls
    bun
    delve
    mockgen
    go-mockery

    # GUI
    vscode
    postman
    zed-editor
    mongodb-compass
    dbeaver-bin

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

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      zd = "zeditor";
      ls = "eza";
    };
  };

  programs.starship.enable = true;

  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_frappe";
    };
  };
}
