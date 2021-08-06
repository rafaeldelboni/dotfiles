(module config.plugin.lualine
  {autoload {core aniseed.core
             lualine lualine
             lsp config.plugin.lspconfig}})

(defn lsp_connection []
  (if (vim.tbl_isempty (vim.lsp.buf_get_clients 0)) "" ""))

(lualine.setup {:options {:theme (core.assoc
                                   (require :lualine.themes.github)
                                   :inactive {:a {:bg "#1b1b1b" :fg "#808080"}
                                              :b {:bg "#1b1b1b" :fg "#808080" :gui "bold"}
                                              :c {:bg "#1b1b1b" :fg "#808080"}})
                          :icons_enabled false
                          :section_separators ["" ""]
                          :component_separators ["" ""]}

                :sections {:lualine_a []
                           :lualine_b [[:mode {:upper true}]]
                           :lualine_c [["FugitiveHead"]
                                       [:filename {:filestatus true
                                                   :path 1}]]
                           :lualine_x [[:diagnostics {:sections [:error
                                                                 :warn
                                                                 :info
                                                                 :hint]
                                                      :sources [:nvim_lsp]}]
                                       [lsp_connection]
                                       :location
                                       :filetype]
                           :lualine_y [:encoding]
                           :lualine_z []}
                :inactive_sections {:lualine_a []
                                    :lualine_b []
                                    :lualine_c [[:filename {:filestatus true
                                                            :path 1}]]
                                    :lualine_x []
                                    :lualine_y []
                                    :lualine_z []}})
