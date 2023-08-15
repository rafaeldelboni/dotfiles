(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :aserowy/tmux.nvim
  :config (fn []
            (let [tmux (require :tmux)]
              (tmux.setup {:copy_sync {:redirect_to_clipboard true}})))}]
