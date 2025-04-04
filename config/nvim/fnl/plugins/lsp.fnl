;symbols to show for lsp diagnostics
(vim.diagnostic.config {:signs {:text {vim.diagnostic.severity.ERROR ""
                                       vim.diagnostic.severity.WARN ""
                                       vim.diagnostic.severity.INFO ""
                                       vim.diagnostic.severity.HINT ""}}})

[{1 :neovim/nvim-lspconfig
  :config (fn []
            (let [lsp (require :lspconfig)
                  cmplsp (require :cmp_nvim_lsp)
                  config-lsp (require :config.lsp)
                  on_attach config-lsp.on_attach
                  handlers config-lsp.handlers
                  before_init config-lsp.before_init
                  capabilities (cmplsp.default_capabilities)]

              ;; To add support to more language servers check:
              ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

              ;; Clojure
              (lsp.clojure_lsp.setup {:on_attach on_attach
                                      :handlers handlers
                                      :before_init before_init
                                      :capabilities capabilities})

              ;; Godot
              (lsp.gdscript.setup {:on_attach on_attach
                                   :handlers handlers
                                   :before_init before_init
                                   :capabilities capabilities})

              ;; Csharp
              (lsp.omnisharp.setup {:on_attach (fn [client bufnr]
                                                 (on_attach client bufnr)
                                                 (vim.api.nvim_buf_set_keymap bufnr :n :gd ":lua require('omnisharp_extended').telescope_lsp_definition()<cr>" {:noremap true})
                                                 (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lt ":lua require('omnisharp_extended').telescope_lsp_type_definition()<CR>" {:noremap true})
                                                 (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lr ":lua require('omnisharp_extended').telescope_lsp_references()<cr>" {:noremap true})
                                                 (vim.api.nvim_buf_set_keymap bufnr :n :<leader>li ":lua require('omnisharp_extended').telescope_lsp_implementation()<cr>" {:noremap true}))
                                    :handlers handlers
                                    :capabilities capabilities
                                    :cmd ["omnisharp"]})

              ;; Fsharp
              (let [fsharp (require :ionide)]
                (fsharp.setup {:autostart true
                               :flags {:debounce_text_changes 150}
                               :on_attach on_attach
                               :handlers handlers
                               :before_init before_init
                               :capabilities capabilities}))

              ;; JavaScript and TypeScript
              (lsp.ts_ls.setup {:on_attach on_attach
                                :handlers handlers
                                :before_init before_init
                                :capabilities capabilities})

              ;; html / css / json
              (lsp.cssls.setup {:on_attach on_attach
                                :handlers handlers
                                :before_init before_init
                                :capabilities capabilities
                                :cmd ["vscode-css-language-server" "--stdio"]})

              (lsp.html.setup {:on_attach on_attach
                               :handlers handlers
                               :before_init before_init
                               :capabilities capabilities
                               :cmd ["vscode-html-language-server" "--stdio"]})

              (lsp.jsonls.setup {:on_attach on_attach
                                 :handlers handlers
                                 :before_init before_init
                                 :capabilities capabilities
                                 :cmd ["vscode-json-language-server" "--stdio"]})

              ;; go
              (lsp.gopls.setup {:on_attach on_attach
                                :handlers handlers
                                :before_init before_init
                                :capabilities capabilities})

              ;; dart
              (lsp.dartls.setup {:on_attach on_attach
                                 :handlers handlers
                                 :before_init before_init
                                 :capabilities capabilities})))}]
