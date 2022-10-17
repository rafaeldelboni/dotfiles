(module config.plugin.nvim-tree
  {autoload {nvim aniseed.nvim
             tree nvim-tree}})

(tree.setup
 {:sort_by "case_sensitive"
  :view {:adaptive_size true
         :mappings {:list [{:key "u" :action "dir_up"}]}}
  :renderer {:group_empty true}
  :filters {:custom ["^\\.git"]}})

(nvim.set_keymap :n :<leader>tt ":NvimTreeToggle<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>tf ":NvimTreeFocus<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>tc ":NvimTreeCollapse<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>tr ":NvimTreeFindFile<CR>" {:noremap true})
