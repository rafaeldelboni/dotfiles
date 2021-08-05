(module config.plugin.tmux-navigator
  {autoload {nvim aniseed.nvim}})

(set nvim.g.tmux_navigator_no_mappings 1)

(nvim.set_keymap :n :<C-h> ":TmuxNavigateLeft<cr>" {:noremap true :silent true})
(nvim.set_keymap :n :<C-j> ":TmuxNavigateDown<cr>" {:noremap true :silent true})
(nvim.set_keymap :n :<C-k> ":TmuxNavigateUp<cr>" {:noremap true :silent true})
(nvim.set_keymap :n :<C-l> ":TmuxNavigateRight<cr>" {:noremap true :silent true})
