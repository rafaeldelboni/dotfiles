(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :nvim-tree/nvim-tree.lua
  :branch "master"
  :config (fn []
            (let [tree (require :nvim-tree)
                  on-attach (fn on-attach [bufnr]
                              (let [api (require :nvim-tree.api)
                                    opts (fn [desc] 
                                           {:buffer bufnr
                                            :desc (.. "nvim-tree: " desc)
                                            :noremap true
                                            :nowait true
                                            :silent true})]
                                (api.config.mappings.default_on_attach bufnr)
                                (vim.keymap.set :n :U api.tree.change_root_to_node (opts "CD"))
                                (vim.keymap.set :n :u api.tree.toggle_custom_filter (opts "Toggle Hidden"))))]
              (tree.setup
                {:on_attach on-attach
                 :sort_by "case_sensitive"
                 :view {:adaptive_size true}
                 :renderer {:group_empty true
                            :indent_markers {:enable false}
                            :icons {:webdev_colors false
                                    :git_placement :after
                                    :glyphs {:bookmark ""
                                             :folder {:default "" :open ""}}}}
                 :filters {:custom ["^\\.git$"]}}
                )))
  :init (fn []
          (nvim.ex.hi "NvimTreeSpecialFile ctermfg=7 guifg=#c6c6c6")
          (nvim.set_keymap :n :<leader>tt ":NvimTreeToggle<CR>" {:noremap true})
          (nvim.set_keymap :n :<leader>tf ":NvimTreeFocus<CR>" {:noremap true})
          (nvim.set_keymap :n :<leader>tc ":NvimTreeCollapse<CR>" {:noremap true})
          (nvim.set_keymap :n :<leader>tr ":NvimTreeFindFile<CR>" {:noremap true}))}]
