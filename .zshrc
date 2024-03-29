# - Theme
# Using startship

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    poetry
)

source "$HOME/.config/zsh/exports.zsh"
source "$HOME/.config/zsh/sources.zsh"
source "$HOME/.config/zsh/evaluation.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/vim_modes.zsh"
source "$HOME/.config/zsh/zoxide.zsh"

figlet PedroS | lolcat
