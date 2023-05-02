(module config.plugin.nvim-tree
  {autoload {nvim aniseed.nvim
             tree nvim-tree
             api nvim-tree.api}})

(fn on-attach [bufnr]
  (let [opts (fn [desc]
               {:buffer bufnr
                :desc (.. "nvim-tree: " desc)
                :noremap true
                :nowait true
                :silent true})]

    (api.config.mappings.default_on_attach bufnr)

    (vim.keymap.set :n :U api.tree.change_root_to_node (opts "CD"))
    (vim.keymap.set :n :u api.tree.toggle_custom_filter (opts "Toggle Hidden"))))

(tree.setup
  {:on_attach on-attach
   :sort_by "case_sensitive"
   :view {:adaptive_size true
          :mappings {:list [{:key "u" :action "dir_up"}]}}
   :renderer {:group_empty true
              :highlight_git false
              :highlight_opened_files "none"
              :indent_markers {:enable false}
              :icons {:webdev_colors false
                      :git_placement :after
                      :padding " "
                      :symlink_arrow " ➛ "
                      :show {:file true
                             :folder true
                             :folder_arrow true
                             :git true}
                      :glyphs {:default ""
                               :folder {:default "" :open ""}
                               :git {:unstaged "✗"
                                     :staged "✓"
                                     :unmerged ""
                                     :renamed "➜"
                                     :untracked "★"}}}}
   :filters {:custom ["^\\.git$"]}})

(nvim.ex.hi "NvimTreeSpecialFile ctermfg=7 guifg=#c6c6c6")

(nvim.set_keymap :n :<leader>tt ":NvimTreeToggle<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>tf ":NvimTreeFocus<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>tc ":NvimTreeCollapse<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>tr ":NvimTreeFindFile<CR>" {:noremap true})
