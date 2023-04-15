(module config.plugin.theme
  {autoload {core aniseed.core
             nvim aniseed.nvim
             theme github-theme}})

(theme.setup {:options {:styles {:comments "italic"}
                        :hide_nc_statusline false}
              :colors {:bg "#1c1b22"}
              :overrides (fn [c]
                           {:ColorColumn {:bg "#19181e"}
                            :NonText {:fg "#323138"}
                            :EndOfBuffer {:fg "#19181e"}
                            :Pmenu {:bg "#19181e"}
                            :VertSplit {:fg "#19181e"}
                            :DiagnosticError {:fg c.error}
                            :DiagnosticWarn {:fg c.warning}
                            :DiagnosticInfo {:fg c.info}
                            :DiagnosticHint {:fg c.hint}})})

(vim.cmd "colorscheme github_dark")
