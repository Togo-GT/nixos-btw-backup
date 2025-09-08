{ config, pkgs, ... }:

{
  # 👤 Brugerinfo
  home.username = "gt";                  # 🙋‍♂️ Dit brugernavn
  home.homeDirectory = "/home/gt";       # 📂 Hjemmemappe
  home.stateVersion = "25.05";           # 🕒 Home Manager state version

  # 🗂️ Home Manager moduler
  imports = [
    ./aliases.nix
    ./zsh.nix
    ./terminal.nix
    ./editors.nix
    ./git.nix
    ./tmux.nix
    ./packages.nix
  ];

  # 🌐 Session variabler
  home.sessionVariables = {
    LANG   = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };
}
