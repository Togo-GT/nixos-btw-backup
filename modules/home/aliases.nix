{ config, pkgs, ... }:

{
  # ----------------------------
  # 🔗 Aliases
  # ----------------------------
  programs.bash = {
    enable = true;
    shellAliases = {
      ll    = "ls -la";
      gs    = "git status";
      co    = "git checkout";
      br    = "git branch";
      cm    = "git commit";
      lg    = "git log --oneline --graph --decorate --all";
      nixup = "sudo nixos-rebuild switch --upgrade --flake /home/gt/nixos#nixos-btw";
      fz    = "fzf";
      rg    = "ripgrep";
      htop  = "htop";
      tree  = "tree";
    };
  };
}
