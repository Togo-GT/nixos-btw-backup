{ config, pkgs, ... }:

let
  # 🔹 Aliases med emojis direkte i prompten
  terminalAliases = {
    ll    = "📂 ls -la";
    gs    = "📝 git status";
    co    = "🔄 git checkout";
    br    = "🌿 git branch";
    cm    = "✅ git commit";
    lg    = "🧾 git log --oneline --graph --decorate --all";
    nixup = "🚀 sudo nixos-rebuild switch --upgrade --flake /home/gt/nixos#nixos-btw";
    fz    = "🔍 fzf";
    rg    = "🔎 ripgrep";
    htop  = "📊 htop";
    tree  = "🌳 tree";
  };
in
{
  # 🐚 Bash
  programs.bash = {
    enable = true;
    shellAliases = terminalAliases;
  };

  # 🐚 Zsh aliases
  home.file.".config/zsh/aliases.zsh".text = builtins.concatStringsSep "\n"
    (builtins.mapAttrsToList (name, cmd: "alias ${name}='${cmd}' # 🔹") terminalAliases);
}
