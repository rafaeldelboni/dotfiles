# theme
ZSH_THEME="lambda"

# Zsh init
export ZSH=~/.oh-my-zsh
plugins=(vi-mode git autojump tmux jira)
source $ZSH/oh-my-zsh.sh

# NVIM S2
alias vim="nvim"
alias vi="nvim"
alias vimdiff='nvim -d'
export EDITOR=nvim

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

HISTSIZE=10000000                # history size
SAVEHIST=10000000                # history save size
DISABLE_AUTO_TITLE="true"        # avoid window rename
KEYTIMEOUT=1                     # remove delay

# PATH adds
PATH="$HOME/.local/bin:/usr/local/bin":$PATH
PATH="$HOME/.cargo/bin:$HOME/.cargo/bin/racer":$PATH

# language specific
[ -f $HOME/.cargo/bin/rustc ] && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src" # rust
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# arch zsh-autosuggestions
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf
export FZF_DEFAULT_OPTS='--color=info:1,prompt:2,spinner:1,pointer:2,marker:1'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ ! $DISPLAY && $XDG_VTNR -eq 1 && $(id --group) -ne 0 ]] && exec startx -- vt1 &> /dev/null

# gpg
export GPG_TTY=$(tty)

# work specific configs
[ -f ~/.nurc ] && source ~/.nurc
