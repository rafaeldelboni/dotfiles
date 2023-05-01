(module config.plugin.theme
  {autoload {core aniseed.core
             nvim aniseed.nvim
             theme github-theme}})

(theme.setup {:options {:styles {:comments "italic"}
                        :hide_nc_statusline false}
              :specs {:all {:bg1 "#1c1b22"}}
              :groups {:all {:ColorColumn {:bg "#19181e"}
                             :NonText {:fg "#323138"}
                             :EndOfBuffer {:fg "#19181e"}
                             :Pmenu {:bg "#19181e"}
                             :VertSplit {:fg "#19181e"}
                             :DiagnosticHint {:link "LspDiagnosticsDefaultHint"}}}})

(vim.cmd "colorscheme github_dark")
