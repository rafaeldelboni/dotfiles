" set the runtime path to include vim-plug and initialize
call plug#begin('~/.vim/plugged')

" Utilities
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'christoomey/vim-tmux-navigator'
" Theme/Visual
Plug 'widatama/vim-phoenix'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Javascript
Plug 'pangloss/vim-javascript'
" Typescript
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
" Rust
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'

call plug#end()

filetype plugin indent on

" Basic sets
set number            " Show line numbers
set ruler             " Show line and column number
set encoding=utf-8    " Set default encoding to UTF-8
set backspace=2
set colorcolumn=80

set ignorecase
set smartcase

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

set rtp+=~/.fzf

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
au FileType php setl sw=4 sts=4 et " Tab spaces for PHP files

set hlsearch                       " enable highlighting search
nnoremap <CR> :noh<CR><CR>         " clear highlighting on enter in normal mode

" NERDTree
map <leader>n :NERDTreeToggle<CR> " Leader + n open/close tree
map <leader>r :NERDTreeFind<cr> " Leader + r show file on tree
autocmd StdinReadPre * let s:std_in=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$[[dir]]']

" FZF
let $FZF_DEFAULT_COMMAND = 'ag --hidden -l --ignore .git'
nnoremap <c-p> :Files<CR>

" Ag
" Default options are --nogroup --column --color
let s:ag_options = ' --skip-vcs-ignores --smart-case -Q '
command! -bang -nargs=* AgQ
      \ call fzf#vim#ag(
      \   <q-args>,
      \   s:ag_options,
      \  <bang>0 ? fzf#vim#with_preview('up:60%')
      \        : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0
      \ )
nnoremap <Leader>a :Ag<Space>
nnoremap <Leader>aq :AgQ<Space>
nnoremap <Leader>ag :Ag <C-R><C-W><CR>

" theme
syntax on
set t_Co=256
set noshowmode
set fillchars=""

color phoenix
PhoenixGreen

hi NonText ctermfg=237
hi SpecialKey ctermfg=237
hi ColorColumn ctermbg=234
hi VertSplit ctermfg=235

" ALE status in Airline
let g:airline#extensions#ale#enabled = 1

" Airline settings
let g:airline_theme = 'minimalist'
let g:airline_powerline_fonts = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_mode_map = {
   \ '__' : '--',
   \ 'n'  : 'N',
   \ 'i'  : 'I',
   \ 'R'  : 'R',
   \ 'c'  : 'C',
   \ 'v'  : 'V',
   \ 'V'  : 'V-L',
   \ 's'  : 'S',
   \ 'S'  : 'S-L',
   \ 't'  : 'T'
   \ }
let g:airline#extensions#branch#displayed_head_limit = 12 " branch name size
let g:airline#extensions#branch#format = 2 " branch name format
let g:airline_left_sep = '' " no separators
let g:airline_left_alt_sep = '' " no separators
let g:airline_right_sep = '' " no separators
let g:airline_right_alt_sep = '' " no separators
let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.notexists = ''
let g:airline_section_x = airline#section#create_right(['tagbar']) " no filetype
call airline#parts#define_raw('linenr', '%l')
call airline#parts#define_accent('linenr', 'bold')
let g:airline_section_z = airline#section#create(['%3p%%  ', g:airline_symbols.linenr .' ', 'linenr', ':%c '])

" Fugitive
nnoremap <leader>g :Git<Space>

" Tmux
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" Ale
let g:ale_lint_on_text_changed = 0 "dont lint on text change
let g:ale_lint_on_save = 1 "lint on save
let g:ale_sign_warning = ''
let g:ale_sign_error = ''
let g:ale_echo_msg_format = '%severity%: %s [%linter%]'
let g:ale_statusline_format = ['E:%s', 'W:%s', 'OK']
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
highlight ALEError cterm=undercurl ctermfg=none
highlight ALEWarning cterm=undercurl ctermfg=none
let g:ale_fixers = { 'javascript': 'eslint', 'php': 'phpcbf' }
map <leader>f :ALEFix<cr>
map <leader>l :ALELint<cr>

" Typescript
au FileType typescript nmap gd <Plug>(TsuquyomiDefinition)
au FileType typescript nmap gs <Plug>(TsuquyomiSplitDefinition)
au FileType typescript nmap gx <Plug>(TsuquyomiRenameSymbol)

" Rust
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" GVim

if has('gui_running')
  set noerrorbells visualbell t_vb= "no bell and visuals
  autocmd GUIEnter * set visualbell t_vb=
  set guifont=FuraMono_Nerd_Font_Mono:h10
  set guioptions-=m "menu bar
  set guioptions-=T "toolbar
  set guioptions-=r "r scrollbar
  set guioptions-=R "R scrollbar
  set guioptions-=l "l scrollbar
  set guioptions-=L "L scrollbar
  set guioptions-=b "b scrollbar
endif
