{ config, pkgs, ... }:

{
  programs.git.enable = true;

  home.file.".gitconfig".text = ''
    [user]
      name = "Togo-GT"
      email = "michael.kaare.nielsen@gmail.com"
    [core]
      editor = nvim
    [alias]
      st = status
      co = checkout
      br = branch
      cm = commit
      lg = log --oneline --graph --decorate --all
    [credential]
      helper = cache --timeout=3600
  '';
}
