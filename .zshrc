# zsh
source ~/.config/antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

export _JAVA_AWT_WM_NONREPARENTING=1

# aliases
alias cls="clear"
alias dnd="dragon-drag-and-drop -x"
alias v="nvim"
alias m="make"
alias y="yay"
alias cf="git --git-dir=$HOME/dotfiles.git --work-tree=$HOME"

# nvm
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"

source /usr/share/nvm/nvm.sh --no-use
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec

PROMPT=" %~ | "
