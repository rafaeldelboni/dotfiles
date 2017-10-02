# Basic settings
export ZSH=~/.oh-my-zsh

ZSH_THEME="agnoster"

plugins=(git autojump httpie npm yarn tmux)

source $ZSH/oh-my-zsh.sh

DEFAULT_USER="rafaeldelboni"

# User configuration

eval "$(pyenv init -)"

# Boot up nvm but defer nvm initialization until node or nvm commands
# # are invoked. This will speed up shell boot up time.
export NVM_DIR="$HOME/.nvm"
source /usr/local/Cellar/nvm/0.33.4/nvm.sh --no-use
alias node='unalias node ; unalias npm ; nvm use default ; node $@'
alias npm='unalias node ; unalias npm ; nvm use default ; npm $@'

PATH="/Users/rafaeldelboni/.composer/vendor/bin":$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
