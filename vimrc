" set the runtime path to include vim-plug and initialize
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'vim-airline/vim-airline'
Plug 'tomasiser/vim-code-dark'
Plug 'pangloss/vim-javascript'
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-multiple-cursors'

call plug#end()

filetype plugin indent on

" Basic sets
set number            " Show line numbers
set ruler             " Show line and column number
set encoding=utf-8    " Set default encoding to UTF-8
set backspace=2
set colorcolumn=80

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

set rtp+=~/.fzf

set visualbell           " don't beep
set noerrorbells         " don't beep

set nobackup             " no backup
set noswapfile           " no backup

set clipboard=unnamed    " Shared clipboard with osx

set nowrap               " don't wrap lines
set tabstop=2            " a tab is two spaces
set shiftwidth=2         " an autoindent (with <<) is two spaces
set softtabstop=2
set expandtab            " use spaces, not tabs
set list                 " Show invisible characters
set listchars=tab:▶-,trail:•,extends:»,precedes:«,eol:¬

au FocusGained,BufEnter * :checktime " Refresh changed content

" NERDTree
map <leader>n :NERDTreeToggle<CR> " Leader + n open/close tree
map <leader>r :NERDTreeFind<cr> " Leader + r show file on tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd p | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$[[dir]]']

" Ack
let g:ack_mappings = {
  \  'v':  '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
  \ 'gv': '<C-W><CR><C-W>L<C-W>p<C-W>J' }

nnoremap <leader>a :Ack<Space>
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" syntax/theme
syntax sync minlines=100
syntax sync maxlines=240
set synmaxcol=800

set t_Co=256
set t_ut=
colorscheme codedark
let g:airline_theme = 'codedark'

hi NonText ctermfg=237 guifg=Grey23     " Invisible chars color
hi SpecialKey ctermfg=237 guifg=Grey23  " Invisible chars color

" FZF
nnoremap <c-p> :Files<CR>

" Fugitive
nnoremap <leader>g :Git<Space>

" Tmux
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" php-cs-fixer
let g:php_cs_fixer_cache = "~/.php_cs.cache" " options: --cache-file
