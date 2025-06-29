{ pkgs, lib, config, ... }:

{
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    bat
    helix
    go
    # vscode
    postman
    iterm2
    starship
    git-credential-oauth
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
