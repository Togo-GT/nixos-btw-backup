{ config, pkgs, ... }:

{
  # ----------------------------
  # 📦 CLI apps
  # ----------------------------
  home.packages = with pkgs; [
    delta lazygit htop curl gparted e2fsprogs
    ripgrep fzf fd bat jq ncdu tree neofetch
    autojump zsh-autosuggestions zsh-syntax-highlighting
  ];
}
