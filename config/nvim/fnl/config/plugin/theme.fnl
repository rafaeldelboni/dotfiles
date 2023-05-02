(module config.plugin.theme
  {autoload {core aniseed.core
             nvim aniseed.nvim
             theme tokyonight}})

(theme.setup {:style :night
              :styles {:comments {:italic true}
                       :floats :dark
                       :functions {}
                       :keywords {:italic true}
                       :sidebars :dark
                       :variables {}}
              :on_colors (fn [colors])
              :on_highlights (fn [highlight colors]
                               (set highlight.String {:fg colors.green2})
                               (set highlight.TelescopeNormal {:bg colors.bg_dark
                                                               :fg colors.fg_dark})
                               (set highlight.TelescopeBorder {:bg colors.bg_dark
                                                               :fg colors.fg_dark})
                               (set highlight.FloatBorder {:bg colors.bg_dark
                                                           :fg colors.fg_dark})
                               (set highlight.ColorColumn {:bg colors.bg_dark
                                                           :fg colors.fg_dark})
                               (set highlight.Pmenu {:bg colors.bg_dark
                                                     :fg colors.fg_dark})
                               (set highlight.NonText {:fg "#2d3149"}))
              :terminal_colors true})

(vim.cmd "colorscheme tokyonight")
