{ config, pkgs, ... }:

{
  # ----------------------------
  # 🐚 Zsh
  # ----------------------------
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "powerlevel10k/powerlevel10k"; # korrekt sti
      plugins = [ "git" "z" "sudo" ];        # øvrige plugins loades manuelt
    };

    initContent = ''
      export EDITOR=nvim
      export VISUAL=nvim

      # Plugins fra Nix
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      source ${pkgs.autojump}/share/autojump/autojump.zsh

      # Git Power Dashboard
      function git_power_dashboard() {
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        if [[ -n $branch ]]; then
          local ahead behind staged unstaged untracked
          ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
          behind=$(git rev-list HEAD..@{u} --count 2>/dev/null || echo 0)
          staged=$(git diff --cached --name-only 2>/dev/null | wc -l)
          unstaged=$(git diff --name-only 2>/dev/null | wc -l)
          untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l)

          local out="" in="" s="" u="" t=""
          [[ $ahead -gt 0 ]] && out="%F{green}↑$ahead%f"
          [[ $behind -gt 0 ]] && in="%F{red}↓$behind%f"
          [[ $staged -gt 0 ]] && s="%F{blue}+$staged%f"
          [[ $unstaged -gt 0 ]] && u="%F{yellow}~$unstaged%f"
          [[ $untracked -gt 0 ]] && t="%F{magenta}?$untracked%f"

          echo "%F{cyan}$branch%f $out$in$s$u$t"
        fi
      }

      typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time background_jobs git_power_dashboard)
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
  };
}
