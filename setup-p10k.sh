#!/usr/bin/env bash
# --------------------------------------
# Setup Powerlevel10k for Home Manager
# --------------------------------------

P10K_FILE="$HOME/.p10k.zsh"

# Tjek om filen allerede findes
if [ -f "$P10K_FILE" ]; then
  echo "💡 $P10K_FILE eksisterer allerede. Ingen ændringer foretaget."
  exit 0
fi

# Opret .p10k.zsh
cat <<'EOF' > "$P10K_FILE"
# ----------------------------
# Powerlevel10k config
# ----------------------------

# ⚡ Prompt segments
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs time)

# 🎨 Colors
POWERLEVEL9K_COLOR_PROMPT_OK=green
POWERLEVEL9K_COLOR_PROMPT_ERROR=red
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=yellow
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=black

# 🏷 Symbols
POWERLEVEL9K_VCS_MODIFIED_ICON='✎'
POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

# ⌨️ Style
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}╭─%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}╰─%f "

# Load Powerlevel10k
[[ ! -f ${HOME}/.nix-profile/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]] || \
  source ${HOME}/.nix-profile/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
EOF

echo "✅ Powerlevel10k konfig oprettet i $P10K_FILE"
echo "🔄 Husk at åbne en ny terminal eller køre 'source ~/.p10k.zsh'"
