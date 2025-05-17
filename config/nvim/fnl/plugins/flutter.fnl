[{1 :nvim-flutter/flutter-tools.nvim
  :lazy true
  :ft [:dart :flutter]
  :config (fn []
            (let [flutter-tools (require :flutter-tools)
                  config-lsp (require :config.lsp)]
              (flutter-tools.setup
                {:lsp {:on_attach config-lsp.on_attach
                       :handlers config-lsp.handlers
                       :before_init config-lsp.before_init}})))
  :dependencies [:nvim-lua/plenary.nvim]}]
