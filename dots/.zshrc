# -------------- oh-my-zsh --------------

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    # fzf-tab
)

export ZSH="$HOME/.oh-my-zsh" # Path to oh-my-zsh folder
source $ZSH/oh-my-zsh.sh # oh-my-zsh

# -------------- Sources --------------

source "$HOME/.config/zsh/pvenv.zsh"
source "$HOME/.config/zsh/func.zsh"

# -------------- Preferences --------------

export BROWSER="firefox"
export EDITOR=nvim
export SUDO_EDITOR=nvim
export VISUAL=nvim
export KEYTIMEOUT=1

# -------------- Variables --------------

export DOTFILES=$HOME/.dotfiles
export XDG_CONFIG_HOME=$HOME/.config

# -------------- Path --------------

setopt extended_glob null_glob

path=(
    $path
    $HOME/.local/bin
    $DOTFILES/bin
    $HOME/.cargo/bin
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH

# -------------- Second Brain --------------

export SECOND_BRAIN_VAULT="$HOME/Nextcloud/NotesVault/"

# -------------- FZF Config --------------

eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border' # FZF
export FZF_DEFAULT_COMMAND='fd --type f'

# -------------- Starship --------------

eval "$(starship init zsh)"

# -------------- Zoxide --------------

eval "$(zoxide init zsh)"

# -------------- Aliases --------------

# Neovim alias
alias v='nvim'
alias nv='nvim'
alias vim='nvim'
alias snv="sudo -E -s ~/.local/share/bob/nvim-bin/nvim"

# Get terminal themes for terminal emulators like terminator
alias get_themes='bash -c "$(wget -qO- https://git.io/vQgMr)"'

# Alias for the Dotfiles repo
alias dot='cd $DOTFILES'

# Alias to open Lazygit
alias lz='lazygit'

alias c='clear'

alias cd='z'

alias ls="eza --icons auto"

# Start a webserver on http://localhost:8000
alias webserver='python3 -m http.server -b "127.0.0.1" 8080'

# PlatformIO
alias pio_act="source $HOME/.platformio/penv/bin/activate"

# Exports ESP IDF Variables
alias get_idf='. $HOME/Tools/esp/esp-idf/export.sh'

# EPS-rust dev
alias get_esprs='. $HOME/Tools/esp/esp-idf/export.sh'

# PNPM
alias pn=pnpm

# File Manager
alias open="nautilus"

# -------------- Vim Mode --------------

# Enabling VIM Keybindings in shell
bindkey -v

# Change cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# -------------- Bun --------------

[ -s "/home/pedros/.bun/_bun" ] && source "/home/pedros/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ----------- SSH Agent -----------

if [ ! -f "$SSH_AUTH_SOCK" ]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
fi

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
    source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
    ssh-add $HOME/.ssh/id_ed25519 > /dev/null
fi


# -------------- End --------------

fastfetch -c $HOME/.config/fastfetch/simple.jsonc
