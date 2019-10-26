call plug#begin('~/.local/share/nvim/plugged')

" Utilities
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
" File Exploration
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'melonmanchan/vim-tmux-resizer'
" Theme/Visual
Plug 'widatama/vim-phoenix'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Javascript / Typescript
Plug 'pangloss/vim-javascript'
Plug 'herringtondarkholme/yats.vim'
" Rust
Plug 'rust-lang/rust.vim'
" Clojure
Plug 'guns/vim-clojure-static'
Plug 'Olical/conjure', { 'branch': 'develop', 'do': 'bin/compile'  }
" Godot
Plug 'rafaeldelboni/vim-gdscript3'

call plug#end()

filetype plugin indent on

" Basic sets
set number               " Show line numbers
set ruler                " Show line and column number
set encoding=utf-8       " Set default encoding to UTF-8
set backspace=2
set colorcolumn=80

set completeopt=longest  " Inserts the longest, ignore native autocomplete
set wildmenu             " Turn on the WiLd menu, auto complete for commands in command line

set ignorecase           " Case insensitive search
set smartcase            " Smart search case

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

set rtp+=~/.fzf

set noerrorbells         " don't beep
set nobackup             " no backup
set noswapfile           " no backup

set clipboard=unnamedplus " Shared clipboard with linux

set nowrap               " don't wrap lines
set tabstop=2            " a tab is two spaces
set shiftwidth=2         " an autoindent (with <<) is two spaces
set softtabstop=2
set expandtab            " use spaces, not tabs
set list                 " Show invisible characters
set listchars=tab:▶-,trail:•,extends:»,precedes:«,eol:¬

set spelllang=pt_br,en

au FocusGained,BufEnter * :checktime " Refresh changed content

set hlsearch                         " enable highlighting search
nnoremap <CR> :noh<CR><CR>           " clear highlighting on enter in normal mode

let mapleader = "\<space>" " Use space as leader key
let maplocalleader = "," " Use , as local leader key

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
" hide lastsatus (> fzf) on fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
 \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Ag
" :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
" :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <Leader>a :Ag<Space>
nnoremap <Leader>ag :Ag <C-R><C-W><CR>
vnoremap <Leader>ag y:Ag <C-r><C-r>"<CR>
noremap <Leader>ag y:Ag <C-r><C-r>"<CR>

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

" Theme
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
let g:ale_linters = { 'javascript': ['eslint'], 'scss': ['stylelint'] }
let g:ale_fixers = { 'javascript': ['eslint'], 'scss': ['stylelint'] }

" Clojure
let g:conjure_nmap_definition = "<localleader>gd"
let g:conjure_nmap_doc = "<localleader>K"
let g:conjure_log_direction = "horizontal"
let g:conjure_log_blacklist = ["up", "ret", "ret-multiline", "load-file", "eval"]
let g:conjure_quick_doc_normal_mode = 0
let g:conjure_quick_doc_insert_mode = 0

" COC.Nvim
let g:coc_global_extensions = ['coc-json', 'coc-conjure', 'coc-rls', 'coc-tsserver']
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
" Use TAB and CR to trigger completion.
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<TAB>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Show documentation on K
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>
