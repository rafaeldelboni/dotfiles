(module config.plugin.theme
  {autoload {core aniseed.core
             nvim aniseed.nvim
             theme github-theme}})

(theme.setup {:themeStyle "dark"
              :commentStyle "italic"
              :hideInactiveStatusline false
              :colors {:bg "#1c1b22"}})

(nvim.ex.hi "ColorColumn guibg=#19181e")
(nvim.ex.hi "NonText ctermfg=7 guifg=#323138")
