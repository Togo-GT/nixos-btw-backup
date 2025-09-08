{ config, pkgs, ... }:

{
  # ----------------------------
  # 🔲 Tmux
  # ----------------------------
  home.file.".tmux.conf".text = ''
    set -g mouse on
    setw -g mode-keys vi
    bind r source-file ~/.tmux.conf \; display "Config reloaded!"
    set -g prefix C-a
    unbind C-b
    bind C-a send-prefix
    set -g status-bg colour234
    set -g status-fg colour136
  '';
}
