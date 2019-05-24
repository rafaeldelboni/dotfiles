" GVim
if has('gui_running')
  set noerrorbells visualbell t_vb= "no bell and visuals
  autocmd GUIEnter * set visualbell t_vb=
  set guifont=FuraMono_Nerd_Font_Mono:h10
  set guioptions-=m "menu bar
  set guioptions-=T "toolbar
  set guioptions-=r "r scrollbar
  set guioptions-=R "R scrollbar
  set guioptions-=l "l scrollbar
  set guioptions-=L "L scrollbar
  set guioptions-=b "b scrollbar
endif

source ~/.config/base.vim
