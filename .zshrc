# - Theme
# Using startship
# zstyle ':omz:plugins:nvm' lazy yes

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    poetry
    nvm
)

source "$HOME/.config/zsh/exports.zsh"
source "$HOME/.config/zsh/sources.zsh"
source "$HOME/.config/zsh/evaluation.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/vim_modes.zsh"
source "$HOME/.config/zsh/zoxide.zsh"
source "$HOME/.config/zsh/functions.zsh"
source "$HOME/.config/zsh/pvenv.zsh"

figlet $(cat /etc/hostname) | lolcat
