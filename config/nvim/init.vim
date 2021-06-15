call plug#begin('~/.local/share/nvim/plugged')

" Utilities
Plug 'dense-analysis/ale'                           " Static analysis / error lint
Plug 'tpope/vim-fugitive'                           " Git Wrapper
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multi selection
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " LSP / Autocomplete
Plug 'scrooloose/nerdcommenter'                     " Code comment
Plug 'junegunn/vim-easy-align'                      " Text alignment 
Plug 'sheerun/vim-polyglot'                         " Syntax highlighting and indentation support
" File Exploration
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'melonmanchan/vim-tmux-resizer'
" Theme/Visual
Plug 'rafaeldelboni/novum.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Clojure
Plug 'Olical/conjure', {'branch': 'master'}
" CSharp
Plug 'OmniSharp/omnisharp-vim'
" Lisp
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

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

set spelllang=en_us

set undofile             " persistent undo, even if you close and reopen Vim

set splitbelow           " open new horizontal panes on down pane
set splitright           " open new vertical panes on right pane

au FocusGained,BufEnter * :checktime " Refresh changed content

set hlsearch                         " enable highlighting search
nnoremap <CR> :noh<CR><CR>           " clear highlighting on enter in normal mode

let mapleader = "\<space>" " Use space as leader key
let maplocalleader = "," " Use , as local leader key

" Opens this file anywhere
command! Vimrc :vs $MYVIMRC

" NERDTree
map <leader>n :NERDTreeToggle<CR> " Leader + n open/close tree
map <leader>r :NERDTreeFind<cr> " Leader + r show file on tree
autocmd StdinReadPre * let s:std_in=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$[[dir]]']

" FZF
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
nnoremap <Leader>p :Buffers<CR>
nnoremap <c-p> :Files<CR>
" hide lastsatus (> fzf) on fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
 \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Ag
" :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
" :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
nnoremap <Leader>a :Ag<Space>
nnoremap <Leader>ag :Ag <C-R><C-W><CR>
vnoremap <Leader>ag y:Ag <C-r><C-r>"<CR>

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
colorscheme novum

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
highlight ALEErrorSign ctermbg=NONE ctermfg=darkred
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
highlight ALEError cterm=undercurl ctermfg=none
highlight ALEWarning cterm=undercurl ctermfg=none
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'scss': ['stylelint'],
\   'clojure': ['clj-kondo'],
\   'cs': ['OmniSharp'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'scss': ['stylelint'],
\}

" Clojure
let g:conjure#mapping#doc_word = "K"
let g:conjure#mapping#def_word = "gd"
let g:conjure#client#clojure#nrepl#eval#auto_require = v:false
let g:conjure#client#clojure#nrepl#connection#auto_repl#enabled = v:false

" COC.Nvim
let g:coc_global_extensions = ['coc-json', 'coc-conjure', 'coc-rust-analyzer', 'coc-tsserver', 'coc-eslint']
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> fb <Plug>(coc-format)

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>ax <Plug>(coc-codeaction-line)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <shift-control-a> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <s-c-a> coc#refresh()
else
  inoremap <silent><expr> <s-c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Show documentation on K
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" CSharp - OmniSharp
augroup omnisharp_commands
  autocmd!

  " Tabtop size 4
  autocmd FileType cs setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> gr <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> gD <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> gI <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> gy <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> K <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> ac <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> ac <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> rn <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Sexp 

let g:sexp_mappings = {
         \ 'sexp_swap_list_backward':    '',
         \ 'sexp_swap_list_forward':     '',
         \ 'sexp_swap_element_backward': '',
         \ 'sexp_swap_element_forward':  '',
         \ }
