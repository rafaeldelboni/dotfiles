dotfiles
===================
![screenshot](https://github.com/RafaelDelboni/dotfiles/blob/master/screenshot.png)
(Here's what my setup looks like. Vim/Tmux)

## Installation

### Basics
Install [Oh-My-ZSH](https://github.com/robbyrussell/oh-my-zsh)

Install [vim](https://vim.sourceforge.io/download.php)
Setup [vim-plug](https://github.com/junegunn/vim-plug)

Install [tmux](https://github.com/tmux/tmux/wiki)

### Dotfiles
Clone this repo (or your own fork!) to your **home** directory (`/Users/username`).
```
$ cd ~
$ git clone https://github.com/RafaelDelboni/dotfiles
```

Install [rcm](https://github.com/thoughtbot/rcm)

Run rcm (this command expects that you cloned your dotfiles to `~/dotfiles/`)
```
$ env RCRC=$HOME/dotfiles/rcrc rcup
```
RCM creates dotfile symlinks (`.vimrc` -> `/dotfiles/vimrc`) from your home directory to your `/dotfiles/` directory.

### Installing Vim Plugins
To install them you'll need vim-plug, as mentioned above.
Once Plug is installed. Open vim (`$ vim`) and type `:PlugInstall`. And then restart vim. You'll need to do this for all the plugins to work.

#### Custom Fonts
You'll need to use a custom font for Airline to look nice. (Seeing weird symbols? This is why!). See here: https://github.com/ryanoasis/nerd-fonts
I use `Knack Nerd Font`. Once installed, go into iterm2 and Profiles > Text. Change both fonts.

