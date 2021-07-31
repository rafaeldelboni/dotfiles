(module config.plugin.easy-align
  {autoload {nvim aniseed.nvim}})

;start interactive EasyAlign in visual mode (e.g. vipga)
(nvim.set_keymap :x :<leader>ea "<Plug>(EasyAlign)" {})
;start interactive EasyAlign for a motion/text object (e.g. gaip)
(nvim.set_keymap :n :<leader>ea "<Plug>(EasyAlign)" {})
