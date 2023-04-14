(module config.plugin.theme
  {autoload {core aniseed.core
             nvim aniseed.nvim
             theme github-theme}})

(theme.setup {:options {:styles {:comments "italic"}
                        :hide_nc_statusline false}
              :colors {:bg "#1c1b22"}
              :overrides (fn [c]
                           {:ColorColumn {:bg "#19181e"}})})

(vim.cmd "colorscheme github_dark")

(nvim.ex.hi "NonText ctermfg=7 guifg=#323138")
(nvim.ex.hi "EndOfBuffer guifg=#19181e")
(nvim.ex.hi "Pmenu guibg=#19181e")
(nvim.ex.hi "VertSplit guifg=#19181e")
