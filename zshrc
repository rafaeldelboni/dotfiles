# Basic settings
export ZSH=~/.oh-my-zsh

ZSH_THEME="agnoster"

plugins=(git autojump httpie npm yarn tmux)

source $ZSH/oh-my-zsh.sh

DEFAULT_USER="rafaeldelboni"

# User configuration

eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

PATH="/Users/rafaeldelboni/.composer/vendor/bin":$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
