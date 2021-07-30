(module config.plugin.nerdtree
  {autoload {nvim aniseed.nvim}})

(nvim.set_keymap :n :<leader>tt ":NERDTreeToggle<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>tr ":NERDTreeFind<CR>" {:noremap true})

;close the tab if nerdtree is the only window remaining in it.
(nvim.ex.autocmd "BufEnter" "*" "if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif")

(set nvim.g.NERDTreeShowHidden 1)
(set nvim.g.NERDTreeIgnore ["\\.git$[[dir]]"])
