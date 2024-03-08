# Alias to open nvim
alias nv='nvim'
alias vim='nvim'

# Alias to navigate to nvim config folder
alias nv_config='cd $DOTFILES/.config/nvim'

# Alias to get terminal themes from gogh themes
alias get_themes='bash -c "$(wget -qO- https://git.io/vQgMr)"'

# Alias to get nerd fonts
alias get_nf='bash -c  "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"'

# Alias for the Dotfiles bare repo
alias dot='cd $DOTFILES'

# Alias to open Lazygit
alias lz='lazygit'

# PlatformIO
alias platform="source $HOME/.platformio/penv/bin/activate"

alias c='clear'

alias sros='source /opt/ros/iron/setup.zsh'

alias penv='python3 -m venv .venv'
alias penva='source .venv/bin/activate'

# EPS-rust dev
alias get_esprs='. $HOME/export-esp.sh'

alias zola='flatpak run org.getzola.zola'

alias cd='z'
alias notes="nvim $SECOND_BRAIN_VAULT/0.\ ✨\ Dashboard.md"

alias snv="sudo -E -s ~/.local/share/bob/nvim-bin/nvim"
