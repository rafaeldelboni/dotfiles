# theme
export TERM="xterm-256color"
ZSH_THEME="lambda"

# Zsh init
export ZSH=~/.oh-my-zsh
plugins=(vi-mode git autojump tmux fzf)
source $ZSH/oh-my-zsh.sh

# NVIM S2
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
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

# clojure
alias clj='clojure'

# java home
export JAVA_HOME=/usr/lib/jvm/default
export GRAALVM_HOME=/usr/lib/jvm/java-11-graalvm

# gpg
export GPG_TTY=$(tty)

# mac zsh-autosuggestions
[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# work specific configs
[ -f ~/.workrc ] && source ~/.workrc

# fnm
[ -f /usr/local/bin/fnm ] && eval "$(fnm env)"
