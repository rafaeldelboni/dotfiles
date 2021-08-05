(module config.core
  {autoload {nvim aniseed.nvim
             util config.util
             str aniseed.string}})

;refresh changed content
(nvim.ex.autocmd "FocusGained,BufEnter" "*" ":checktime")

;don't wrap lines
(nvim.ex.set :nowrap)

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
       :hlsearch true}]
  (each [option value (pairs options)]
    (util.set-global-option option value)))
