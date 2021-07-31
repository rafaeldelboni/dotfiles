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
                           :lualine_x [["coc#status"]
                                       :location
                                       :filetype]
                           :lualine_y [:encoding]
                           :lualine_z []}
                :inactive_sections {:lualine_a []
                                    :lualine_b []
                                    :lualine_c [[:filename {:filestatus true
                                                            :color {:fg "#868686"
                                                                    :bg "#191919"}}]]
                                    :lualine_x []
                                    :lualine_y []
                                    :lualine_z []}})
