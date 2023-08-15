(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

;generic mapping leaders configuration
(nvim.set_keymap :n :<space> :<nop> {:noremap true})

;clear highlighting on enter in normal mode
(nvim.set_keymap :n :<CR> ":noh<CR><CR>" {:noremap true})

;duplicate currents panel in a new tab
(nvim.set_keymap :n :<C-w>T ":tab split<CR>" {:noremap true :silent true})

;escape from terminal normal mode
(nvim.set_keymap :t :<esc><esc> "<c-\\><c-n>" {:noremap true})

{}
