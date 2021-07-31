(module config.plugin.lualine
  {autoload {lualine lualine}})

(lualine.setup {:options {:theme :codedark
                          :icons_enabled false
                          :section_separators ["" ""]
                          :component_separators ["" ""]}

                :sections {:lualine_a []
                           :lualine_b [[:mode {:upper true}]]
                           :lualine_c [["FugitiveHead"]
                                       [:filename {:filestatus true}]]
                           :lualine_x [[:diagnostics {:sections [:error
                                                                 :warn
                                                                 :info
                                                                 :hint]
                                                      :sources [:coc]}]
                                       :location
                                       :filetype]
                           :lualine_y [:encoding]
                           :lualine_z []}})
