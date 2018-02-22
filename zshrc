# Basic settings
PATH="/usr/local/bin:$HOME/.config/composer/vendor/bin:$HOME/.cargo/bin":$PATH
DISABLE_AUTO_TITLE="true"
DEFAULT_USER="rafael"
ZSH_THEME="minimal"
plugins=(git autojump httpie npm yarn tmux)
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Start Tmux if available
if [ -z "$TMUX" ]
then
    tmux new-session
fi

# User configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
