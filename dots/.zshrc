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

alias cd='zd'

alias ls='eza -lh --group-directories-first --icons=auto'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

# Start a webserver on http://localhost:8000
alias webserver='python3 -m http.server -b "127.0.0.1" 8080'

# PlatformIO
alias pio_act="source $HOME/.platformio/penv/bin/activate"

# Exports ESP IDF Variables
alias get_idf='. $HOME/tools/esp/esp-idf/export.sh'

# EPS-rust dev
alias get_esprs='. $HOME/Tools/esp/esp-idf/export.sh'

# PNPM
alias pn=pnpm

# File Manager
alias open="nautilus"

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias g='git'
alias d='docker'

# Git
alias gpl='git pull'
alias gp='git push'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'


# From Omarchy Bash
# Shows a small preview if zoxide changes directory based on path
function zd() {
    if [ $# -eq 0 ]; then
        builtin cd ~ && return
    elif [ -d "$1" ]; then
        builtin cd "$1"
    else
        z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
}

function open() {
    xdg-open "$@" >/dev/null 2>&1 &
}


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
#
# if [ ! -f "$SSH_AUTH_SOCK" ]; then
#     source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
# fi
#
# if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#     ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
#     source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
#     ssh-add $HOME/.ssh/id_ed25519 > /dev/null
# fi


# -------------- End --------------

# fastfetch -c $HOME/.config/fastfetch/simple.jsonc

# -------------- Functions --------------

# These functions have been ported from Omarchy

# Compression
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

# Write iso file to sd card
iso2sd() {
    if [ $# -ne 2 ]; then
        echo "Usage: iso2sd <input_file> <output_device>"
        echo "Example: iso2sd ~/Downloads/ubuntu-25.04-desktop-amd64.iso /dev/sda"
        echo -e "\nAvailable SD cards:"
        lsblk -d -o NAME | grep -E '^sd[a-z]' | awk '{print "/dev/"$1}'
    else
        sudo dd bs=4M status=progress oflag=sync if="$1" of="$2"
        sudo eject $2
    fi
}

# Format an entire drive for a single partition using ext4
format-drive() {
    if [ $# -ne 2 ]; then
        echo "Usage: format-drive <device> <name>"
        echo "Example: format-drive /dev/sda 'My Stuff'"
        echo -e "\nAvailable drives:"
        lsblk -d -o NAME -n | awk '{print "/dev/"$1}'
    else
        echo "WARNING: This will completely erase all data on $1 and label it '$2'."
        read -rp "Are you sure you want to continue? (y/N): " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            sudo wipefs -a "$1"
            sudo dd if=/dev/zero of="$1" bs=1M count=100 status=progress
            sudo parted -s "$1" mklabel gpt
            sudo parted -s "$1" mkpart primary ext4 1MiB 100%
            sudo mkfs.ext4 -L "$2" "$([[ $1 == *"nvme"* ]] && echo "${1}p1" || echo "${1}1")"
            sudo chmod -R 777 "/run/media/$USER/$2"
            echo "Drive $1 formatted and labeled '$2'."
        fi
    fi
}

# Transcode a video to a good-balance 1080p that's great for sharing online
transcode-video-1080p() {
    ffmpeg -i $1 -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy ${1%.*}-1080p.mp4
}

# Transcode a video to a good-balance 4K that's great for sharing online
transcode-video-4K() {
    ffmpeg -i $1 -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k ${1%.*}-optimized.mp4
}

# Transcode any image to JPG image that's great for shrinking wallpapers
img2jpg() {
    magick $1 -quality 95 -strip ${1%.*}.jpg
}

# Transcode any image to JPG image that's great for sharing online without being too big
img2jpg-small() {
    magick $1 -resize 1080x\> -quality 95 -strip ${1%.*}.jpg
}

# Transcode any image to compressed-but-lossless PNG
img2png() {
    magick "$1" -strip -define png:compression-filter=5 \
        -define png:compression-level=9 \
        -define png:compression-strategy=1 \
        -define png:exclude-chunk=all \
        "${1%.*}.png"
}

# opencode
export PATH=/home/pedro/.opencode/bin:$PATH
eval "$(mise activate zsh)"


export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_HOME="$HOME/.config/.android"
export ANDROID_AVD_HOME="$HOME/.config/.android/avd"
export NDK_HOME="$ANDROID_HOME/ndk/30.0.16138531"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"

# Android/Gradle needs an older JDK than system default (system java 26 too new for Gradle 9.1)
export JAVA_HOME=/opt/android-studio/jbr
