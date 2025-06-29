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
    
    # go
    go
    delve
    gopls

    # GUI
    vscode
    postman
    iterm2

    # podman
    podman
    podman-compose
  ];

  programs.starship = {
    enable = true;
  };

  home.file = {
    ".zshrc".source = dotfiles/.zshrc;
  };

  programs.home-manager.enable = true;
}
