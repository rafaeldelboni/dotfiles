(module config.plugin.theme
  {autoload {core aniseed.core
             nvim aniseed.nvim
             theme github-theme}})

(theme.setup {:themeStyle "dark"
              :commentStyle "italic"
              :hideInactiveStatusline true
              :colors {:bg "#1b1b1b"}})

(nvim.ex.hi "ColorColumn guibg=#303030")
(nvim.ex.hi "NonText ctermfg=7 guifg=#303030")
