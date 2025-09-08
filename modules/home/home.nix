{ config, pkgs, ... }:

{
  imports = [
    ./modules/home/zsh.nix
    ./modules/home/aliases.nix
    ./modules/home/terminal.nix
    ./modules/home/editors.nix
    ./modules/home/git.nix
    ./modules/home/tmux.nix
    ./modules/home/packages.nix
  ];

  home.username = "gt";
  home.homeDirectory = "/home/gt";
  home.stateVersion = "25.05";

  home.sessionVariables = {
    LANG   = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };
}
