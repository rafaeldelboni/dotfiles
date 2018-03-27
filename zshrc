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

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# PATH adds
PATH="/usr/local/bin":$PATH
PATH="$HOME/.cargo/bin:$HOME/.cargo/bin/racer":$PATH

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
