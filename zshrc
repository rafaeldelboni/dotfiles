# theme
ZSH_THEME="minimal"

# Zsh init
export ZSH=~/.oh-my-zsh
plugins=(git autojump httpie yarn tmux)
source $ZSH/oh-my-zsh.sh

# prompt overide
PROMPT='%2~ $(vcs_status)%b '

# avoid window rename
DISABLE_AUTO_TITLE="true"

# remove delay
KEYTIMEOUT=1

# start Tmux if available
if [ -z "$TMUX" ]
then
    tmux new-session
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# PATH adds
PATH="/usr/local/bin:$HOME/.config/composer/vendor/bin:$HOME/.cargo/bin":$PATH

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
