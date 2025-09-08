{ config, pkgs, ... }:

{
  # ----------------------------
  # ✍️ Editors
  # ----------------------------
  programs.vim.enable = true;
  programs.neovim.enable = true;
  home.file.".config/nvim/init.vim".text = ''
    set number
    syntax on
    filetype plugin indent on
    set tabstop=2
    set shiftwidth=2
    set expandtab
    set clipboard=unnamedplus
  '';

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python
      eamodio.gitlens
      vscodevim.vim
      ms-toolsai.jupyter
    ];
  };
}
