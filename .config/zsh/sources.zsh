source $ZSH/oh-my-zsh.sh # oh-my-zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # FZF

# [ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

source "$HOME/.cargo/env"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
