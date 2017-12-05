# Basic settings
DEFAULT_USER="rafaeldelboni"

PATH="/usr/local/bin:/Users/rafaeldelboni/.composer/vendor/bin":$PATH

export ZSH=~/.oh-my-zsh

ZSH_THEME="agnoster"

plugins=(git autojump httpie npm yarn tmux)

source $ZSH/oh-my-zsh.sh

# User configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
