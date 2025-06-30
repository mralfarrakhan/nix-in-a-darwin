{ pkgs, lib, config, ... }:

{
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # basic
    bat
    helix

    # indirect
    starship
    git-credential-oauth
    
    # programming
    go

    # GUI
    vscode
    postman
    iterm2

    # podman
    podman
    podman-compose
  ];

  home.file = {
    ".zshrc".source = ./dotfiles/.zshrc;
    ".config/helix/config.toml".source = ./dotfiles/.config/helix/config.toml;
  };

  programs.home-manager.enable = true;
}
