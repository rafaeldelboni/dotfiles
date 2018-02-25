dotfiles
===================
![screenshot](https://github.com/RafaelDelboni/dotfiles/blob/master/docs/screenshot.png)
(Here's what my setup looks like. Vim/Tmux)

## Installation

### Basics
Install [Oh-My-ZSH](https://github.com/robbyrussell/oh-my-zsh)

Install [vim](https://vim.sourceforge.io/download.php) and setup [vim-plug](https://github.com/junegunn/vim-plug)

Install [tmux](https://github.com/tmux/tmux/wiki)

Install [rcm](https://github.com/thoughtbot/rcm)

### Dotfiles
Clone this repo (or your own fork!) to your **home** directory (`/Users/username`).
```
$ cd ~
$ git clone --recurse-submodules git@github.com:RafaelDelboni/dotfiles.git .dotfiles
$ rcup -x docs -x readme.md
$ xrdb ~/.Xresources
```

`rcup` expects that you cloned your dotfiles to `~/.dotfiles/` and will create dotfile symlinks (`.vimrc` -> `~/.dotfiles/vimrc`) from your home directory to your `~/.dotfiles/` directory.

`xrdb ~/.Xresources` sync the Xresources file with your current XServer

### Installing Vim Plugins
To install them you'll need vim-plug, as mentioned above.
Once Plug is installed. Open vim (`$ vim`) and type `:PlugInstall`. And then restart vim. You'll need to do this for all the plugins to work.

#### Custom Fonts
You'll need to use a custom font for Airline to look nice. (Seeing weird symbols? This is why!). See here: https://github.com/ryanoasis/nerd-fonts
I use `Knack Nerd Font`. Once installed, go into iterm2 and Profiles > Text. Change both fonts.

