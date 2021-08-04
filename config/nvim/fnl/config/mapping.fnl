(module config.mapping
  {autoload {nvim aniseed.nvim}})

;generic mapping leaders configuration
(nvim.set_keymap :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

;clear highlighting on enter in normal mode
(nvim.set_keymap :n :<CR> ":noh<CR><CR>" {:noremap true})

;duplicate currents panel in a new tab
(nvim.set_keymap :n :<C-w>T ":tab split<CR>" {:noremap true :silent true})

;temporary coc settings
;(nvim.set_keymap :n :<leader>rn "<Plug>(coc-rename)" {})
;(nvim.set_keymap :n :<leader>ac "<Plug>(coc-codeaction)" {})
;(nvim.set_keymap :n :<leader>ax "<Plug>(coc-codeaction-line)" {})
