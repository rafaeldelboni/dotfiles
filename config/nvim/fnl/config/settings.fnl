(local {: autoload} (require :nfnl.module))
(local str (autoload :nfnl.string))
(local nvim (autoload :nvim))
(local core (autoload :nfnl.core))

;refresh changed content
(nvim.ex.autocmd "FocusGained,BufEnter" "*" ":checktime")

;rust tabsize
(nvim.ex.autocmd "FileType" "rust" "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")

;csharp tabsize
(nvim.ex.autocmd "FileType" "cs" "setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab")

;godot tabsize
(nvim.ex.autocmd "FileType" "gdscript,gdshader" "setlocal foldmethod=expr tabstop=4 shiftwidth=4 indentexpr= noexpandtab")

;don't wrap lines
(nvim.ex.set :nowrap)

;sets a nvim global options
(let [options
      {:encoding "utf-8"
       :spelllang "en_us"
       :backspace "2"
       :colorcolumn "80"
       :errorbells true
       :backup false
       :swapfile false
       :showmode false
       ;show line numbers
       :number true
       ;show line and column number
       :ruler true
       ;settings needed for compe autocompletion
       :completeopt "menuone,noselect"
       ;turn on the wild menu, auto complete for commands in command line
       :wildmenu true
       :wildignore "*/tmp/*,*.so,*.swp,*.zip"
       ;case insensitive search
       :ignorecase true
       ;smart search case
       :smartcase true
       ;shared clipboard with linux
       :clipboard "unnamedplus"
       ;show invisible characters
       :list true
       :listchars (str.join "," ["tab:▶-" "trail:•" "extends:»" "precedes:«" "eol:¬"])
       ;tabs is space
       :expandtab true
       ;tab/indent size
       :tabstop 2
       :shiftwidth 2
       :softtabstop 2
       ;persistent undo
       :undofile true
       ;open new horizontal panes on down pane
       :splitbelow true
       ;open new vertical panes on right pane
       :splitright true
       ;enable highlighting search
       :hlsearch true
       ;makes signcolumn always one column with signs and linenumber
       :signcolumn "number"}]
  (each [option value (pairs options)]
    (core.assoc nvim.o option value)))

{}
