(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :akinsho/toggleterm.nvim
  :config (fn []
            (let [toggleterm (require :toggleterm)]
              (toggleterm.setup 
                {:open_mapping "<leader>to"
                 :direction "vertical"
                 :size 120
                 :shade_terminals true
                 :start_in_insert true
                 :insert_mappings false
                 :terminal_mappings false})))
  :init (fn []
          (nvim.set_keymap :n :<leader>tl ":TermSelect<CR>" {:noremap true})
          (nvim.ex.tnoremap :<esc> :<c-\><c-n>)
          (nvim.ex.tnoremap :<c-h> :<c-\><c-n><c-w>h)
          (nvim.ex.tnoremap :<c-j> :<c-\><c-n><c-w>j)
          (nvim.ex.tnoremap :<c-k> :<c-\><c-n><c-w>k)
          (nvim.ex.tnoremap :<c-l> :<c-\><c-n><c-w>l))}]
