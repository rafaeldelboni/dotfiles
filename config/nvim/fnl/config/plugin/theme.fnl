(module config.plugin.theme
  {autoload {core aniseed.core
             nvim aniseed.nvim
             theme github-theme}})

(theme.setup {:theme_style "dark"
              :comment_style "italic"
              :hide_inactive_statusline false
              :colors {:bg "#1c1b22"}})

(nvim.ex.hi "ColorColumn guibg=#19181e")
(nvim.ex.hi "NonText ctermfg=7 guifg=#323138")
(nvim.ex.hi "EndOfBuffer guifg=#19181e")
(nvim.ex.hi "Pmenu guibg=#19181e")
(nvim.ex.hi "VertSplit guifg=#19181e")
