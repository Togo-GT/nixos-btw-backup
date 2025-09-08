{ config, pkgs, ... }:

{
  # ----------------------------
  # 🐚 Shell / Terminal
  # ----------------------------
  programs.zsh = {
    enable = true;                             # 🐚 Aktivér Zsh
    enableCompletion = true;                   # ✅ Autocompletion
    autosuggestions.enable = true;             # 💡 Forslag
    syntaxHighlighting.enable = true;          # 🎨 Syntax highlighting

    ohMyZsh = {
      enable = true;                           # ⚡ Oh My Zsh
      theme = "robbyrussell";                  # 🎭 Tema
      plugins = [
        "git" "z" "sudo" "autojump"
        "syntax-highlighting" "history-substring-search"
      ];
    };
  };

  # 🛠 CLI-værktøjer
  environment.systemPackages = with pkgs; [
    wget curl htop neofetch tree nil
  ];
}
