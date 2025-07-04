{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # basic
    bat
    helix
    ripgrep

    # indirect
    starship
    
    # programming
    go
    gcc
    clang-tools

    # GUI
    vscode
    postman
    iterm2
    zed-editor

    # podman
    podman
    podman-compose
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
    shellAliases = {
      zd = "zeditor";
    };
  };

  programs.starship.enable = true;

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox_dark_soft";
    };
  };
}
