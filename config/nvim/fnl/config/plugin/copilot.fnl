(module config.plugin.copilot
  {autoload {nvim aniseed.nvim}})

(nvim.set_keymap :n :<leader>gp ":Copilot panel<CR>" {:noremap true})
(nvim.set_keymap :i "<C-J>" "copilot#Accept(\"<CR>\")" {:silent true :expr true})
(nvim.set_keymap :i "<C-A>" "copilot#Previous()" {:expr true})
(nvim.set_keymap :i "<C-S>" "copilot#Next()" {:expr true})

(set nvim.g.copilot_assume_mapped true)

; disabled by default
(set nvim.g.copilot_enabled false)
