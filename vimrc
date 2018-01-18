" set the runtime path to include vim-plug and initialize
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript'
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-multiple-cursors'
Plug 'mxw/vim-jsx'
Plug 'dim13/smyck.vim'

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

" NERDTree
map <leader>n :NERDTreeToggle<CR> " Leader + n open/close tree
map <leader>r :NERDTreeFind<cr> " Leader + r show file on tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd p | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$[[dir]]']

" Ag
nnoremap <Leader>a :Ag<Space>
nnoremap <Leader>ag :Ag <C-R><C-W><CR>
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" theme
syntax on
color smyck

hi NonText  ctermfg=239
hi SpecialKey ctermfg=239
hi ColorColumn ctermbg=236
hi LineNr ctermfg=239

set fillchars=""


" ALE status in Airline
call airline#parts#define_function('ALE', 'ALEGetStatusLine')
call airline#parts#define_condition('ALE', 'exists("*ALEGetStatusLine")')
let g:airline_section_error = airline#section#create_right(['ALE'])

" Airline settings
set noshowmode
let g:airline_powerline_fonts = 0
let g:airline_theme = 'deus'
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

" FZF
nnoremap <c-p> :Files<CR>
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

" Fugitive
nnoremap <leader>g :Git<Space>

" Tmux
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" JSX
highlight link xmlEndTag xmlTag 
let g:jsx_ext_required = 0 " JSX should not be required as an extension

" Ale
let g:ale_lint_on_text_changed = 0 "dont lint on text change
let g:ale_lint_on_save = 1 "lint on save
let g:ale_sign_warning = ''
let g:ale_sign_error = ''
let g:ale_echo_msg_format = '%severity%: %s [%linter%]'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
highlight ALEError cterm=underline ctermfg=none
highlight ALEWarning cterm=underline ctermfg=none
let g:ale_fixers = { 'javascript': 'eslint', 'php': 'phpcbf' }
map <leader>f :ALEFix<cr>
map <leader>l :ALELint<cr>
