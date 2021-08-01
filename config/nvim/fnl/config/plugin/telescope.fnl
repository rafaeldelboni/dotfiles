(module config.plugin.telescope
  {autoload {nvim aniseed.nvim
             telescope telescope}})

(telescope.setup {
  :defaults {
    :file_ignore_patterns ["node_modules"]
  }})

(nvim.set_keymap :n :<leader>ff ":lua require('telescope.builtin').find_files()<cr>" {:noremap true})
(nvim.set_keymap :n :<leader>fg ":lua require('telescope.builtin').live_grep()<cr>" {:noremap true})
(nvim.set_keymap :n :<leader>fb ":lua require('telescope.builtin').buffers()<cr>" {:noremap true})
(nvim.set_keymap :n :<leader>fh ":lua require('telescope.builtin').help_tags()<cr>" {:noremap true})
