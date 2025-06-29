{ pkgs, lib, config, ... }:

{
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    helix
    go
    vscode
    iterm2
    starship
    git-credential-oauth
    podman
    podman-compose
  ];

  programs.starship = {
    enable = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
  ];
}