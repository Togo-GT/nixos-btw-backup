{ config, pkgs, ... }:

{
  home.file.".tmux.conf".text = ''
    # 🖱️ Mus og vi-mode
    set -g mouse on
    setw -g mode-keys vi

    # ⬆️ Prefix Ctrl-a
    set -g prefix C-a
    unbind C-b
    bind C-a send-prefix

    # 🔄 Genindlæs config: prefix + r
    bind r source-file ~/.tmux.conf \; display-message "🔁 Config reloaded! ✅"

    # 🎨 Pane-border
    set -g pane-border-style "fg=colour238"
    set -g pane-active-border-style "fg=colour39"
    setw -g mode-style bg=colour238,fg=colour45

    # 🎨 Statusbar
    set -g status-bg colour234
    set -g status-fg colour136
    set -g status-left-length 80
    set -g status-right-length 500
    set -g status-interval 1  # update hvert sekund for puls

    # 📌 Venstre status: session, vindue, git branch
    set -g status-left "#[fg=colour39,bold]🌐 #S #[fg=colour136]| 🪟 #I:#W #[fg=colour45]| 🌿 #(git -C #{pane_current_path} rev-parse --abbrev-ref HEAD 2>/dev/null || echo '-')"

    # 📊 Højre status: pulserende sparkline + mini-stænger CPU/RAM + NET + Git + Batteri + Dato/Tid
    set -g status-right "#( \
      CPU=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print int(usage)}'); \
      RAM=$(free -m | awk '/Mem:/ {printf \"%d\", $3/$2*100}'); \
      bars=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █); cpu_bar=''; ram_bar=''; \
      for i in $(seq 1 10); do \
        rand=$((RANDOM%2)); \
        cidx=$(( CPU*7/100 + rand )); [ $cidx -gt 7 ] && cidx=7; \
        ridx=$(( RAM*7/100 + rand )); [ $ridx -gt 7 ] && ridx=7; \
        CPU_COLOR=$( if [ $CPU -ge 80 ]; then echo '#[fg=colour196,bold]'; elif [ $CPU -ge 50 ]; then echo '#[fg=colour202]'; else echo '#[fg=colour46]'; fi ); \
        RAM_COLOR=$( if [ $RAM -ge 80 ]; then echo '#[fg=colour196,bold]'; elif [ $RAM -ge 50 ]; then echo '#[fg=colour202]'; else echo '#[fg=colour46]'; fi ); \
        cpu_bar+=\"${CPU_COLOR}${bars[$cidx]}\"; ram_bar+=\"${RAM_COLOR}${bars[$ridx]}\"; \
      done; \
      cpu_bar+=" [$(seq -s\"\" 1 $((CPU/10)) | sed 's/[0-9]/█/g')]"; \
      ram_bar+=" [$(seq -s\"\" 1 $((RAM/10)) | sed 's/[0-9]/█/g')]"; \
      # NET pulserende
      NET_RX_PREV=$(cat /tmp/tmux_net_rx 2>/dev/null || echo 0); \
      NET_TX_PREV=$(cat /tmp/tmux_net_tx 2>/dev/null || echo 0); \
      NET_RX_CUR=$(cat /sys/class/net/enp0s3/statistics/rx_bytes 2>/dev/null || echo 0); \
      NET_TX_CUR=$(cat /sys/class/net/enp0s3/statistics/tx_bytes 2>/dev/null || echo 0); \
      NET_RX=$(( (NET_RX_CUR - NET_RX_PREV)/1024 )); NET_TX=$(( (NET_TX_CUR - NET_TX_PREV)/1024 )); \
      echo $NET_RX_CUR >/tmp/tmux_net_rx; echo $NET_TX_CUR >/tmp/tmux_net_tx; \
      NET_COLOR=$( if [ $NET_RX -ge 1024 ] || [ $NET_TX -ge 1024 ]; then echo '#[fg=colour39,bold]'; elif [ $NET_RX -ge 512 ] || [ $NET_TX -ge 512 ]; then echo '#[fg=colour202,bold]'; else echo '#[fg=colour45,bold]'; fi ); \
      NET_ICON="📶"; \
      NET_BAR="[ $(seq -s\"\" 1 $(( (NET_RX+NET_TX)/512 )) | sed 's/[0-9]/▇/g') ]"; \
      # Git pulserende (skifter farve hvis ændringer)
      GIT=$(git -C #{pane_current_path} diff --shortstat 2>/dev/null || echo '0'); \
      GIT_COLOR=$( if [ \"$GIT\" != \"0\" ]; then echo '#[fg=colour196,bold]'; else echo '#[fg=colour45]'; fi ); \
      GIT_BAR="[ $(seq -s\"\" 1 $((RANDOM%5+1)) | sed 's/[0-9]/▇/g') ]"; \
      # Batteri
      BAT=$(acpi 2>/dev/null | cut -d',' -f2 | tr -d ' ' || echo 'N/A'); \
      # Udskriv alt
      echo \"CPU:${cpu_bar}#[fg=colour136] | RAM:${ram_bar}#[fg=colour136] | ${NET_COLOR}${NET_ICON} NET:${NET_RX}KB/s↓ ${NET_TX}KB/s↑ ${NET_BAR} | ${GIT_COLOR}Git diff: $GIT ${GIT_BAR}#[fg=colour136] | 🔋 $BAT | 📅 %Y-%m-%d ⏰ %H:%M\" \
    )"

    # 🖥️ Pane navigation (HJKL)
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    # ➗ Split vinduer
    bind | split-window -h
    bind - split-window -v

    # 🔍 Resize pane hurtigt
    bind < resize-pane -L 5
    bind > resize-pane -R
    bind + resize-pane -U 5
    bind _ resize-pane -D 5

    # 🎯 Auto-rename og historie
    setw -g automatic-rename on
    set -g history-limit 10000

    # ⚡ Optimering
    set -g base-index 1
    setw -g pane-base-index 1

    # 🧩 TPM setup
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g @plugin 'tmux-plugins/tmux-resurrect'
    set -g @plugin 'tmux-plugins/tmux-continuum'
    set -g @plugin 'tmux-plugins/tmux-prefix-highlight'

    # ⚡ TPM bind for install/update
    run '~/.tmux/plugins/tpm/tpm'

    # 🔔 Continuum auto-save
    set -g @continuum-restore 'on'
    set -g @continuum-save-interval '15'
  '';
}
