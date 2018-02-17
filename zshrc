# Basic settings
PATH="/usr/local/bin:$HOME/.config/composer/vendor/bin:$HOME/.cargo/bin":$PATH
DISABLE_AUTO_TITLE="true"
DEFAULT_USER="rafael"
ZSH_THEME="agnoster"
plugins=(git autojump httpie npm yarn tmux)
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Start Tmux if available
if [ -z "$TMUX" ]
then
    tmux attach -t TMUX || tmux new -s TMUX
fi

# User configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
