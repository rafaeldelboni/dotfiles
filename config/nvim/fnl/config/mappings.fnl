;generic mapping leaders configuration
(vim.keymap.set :n :<space> :<nop> {:noremap true})

;clear highlighting on enter in normal mode
(vim.keymap.set :n :<CR> ":noh<CR><CR>" {:noremap true})

;duplicate currents panel in a new tab
(vim.keymap.set :n :<C-w>T ":tab split<CR>" {:noremap true :silent true})

;escape from terminal normal mode
(vim.keymap.set :t :<esc><esc> "<c-\\><c-n>" {:noremap true})

{}
