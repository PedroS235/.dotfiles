# Alias to open nvim
alias nv='nvim'
alias vim='nvim'

# Alias to navigate to nvim config folder
alias nv_config='cd $DOTFILES/.config/nvim'

# Alias to get terminal themes from gogh themes
alias get_themes='bash -c "$(wget -qO- https://git.io/vQgMr)"'

# Alias for the Dotfiles bare repo
alias dot='cd $DOTFILES'

# Alias to open Lazygit
alias lz='lazygit'

# PlatformIO
alias pio_act="source $HOME/.platformio/penv/bin/activate"

alias c='clear'

# EPS-rust dev
alias get_esprs='. $HOME/export-esp.sh'

alias zola='flatpak run org.getzola.zola'

alias cd='z'
alias notes="cd $SECOND_BRAIN_VAULT && nvim $SECOND_BRAIN_VAULT/0.\ ✨\ Dashboard.md"

alias snv="sudo -E -s ~/.local/share/bob/nvim-bin/nvim"

# Start a webserver on http://localhost:8000
alias webserver='python3 -m http.server -b localhost 8000'
