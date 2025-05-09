;symbols to show for lsp diagnostics
(vim.diagnostic.config {:signs {:text {vim.diagnostic.severity.ERROR ""
                                       vim.diagnostic.severity.WARN ""
                                       vim.diagnostic.severity.INFO ""
                                       vim.diagnostic.severity.HINT ""}}})

[{1 :neovim/nvim-lspconfig
  :config (fn []
            (let [lsp (require :lspconfig)
                  config-lsp (require :config.lsp)
                  on_attach config-lsp.on_attach
                  handlers config-lsp.handlers
                  before_init config-lsp.before_init]

              ;; For more language servers check:
              ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

              (vim.lsp.config :* {:on_attach on_attach
                                  :handlers handlers
                                  :before_init before_init})

              ;; Clojure
              (vim.lsp.config :clojure_lsp {:root_dir (fn [bufnr on_dir]
                                                        (let [pattern (vim.api.nvim_buf_get_name bufnr)
                                                              util (require :lspconfig.util)
                                                              fallback (vim.loop.cwd)
                                                              patterns [:project.clj :deps.edn :build.boot :shadow-cljs.edn :.git :bb.edn]
                                                              root ((util.root_pattern patterns) pattern)]
                                                          (on_dir (or root fallback))))})
              (vim.lsp.enable :clojure_lsp)

              ;; Godot
              (vim.lsp.enable :gdscript)

              ;; Csharp
              (vim.lsp.config :omnisharp {:on_attach (fn [client bufnr]
                                                       (on_attach client bufnr)
                                                       (vim.api.nvim_buf_set_keymap bufnr :n :gd ":lua require('omnisharp_extended').telescope_lsp_definition()<cr>" {:noremap true})
                                                       (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lt ":lua require('omnisharp_extended').telescope_lsp_type_definition()<CR>" {:noremap true})
                                                       (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lr ":lua require('omnisharp_extended').telescope_lsp_references()<cr>" {:noremap true})
                                                       (vim.api.nvim_buf_set_keymap bufnr :n :<leader>li ":lua require('omnisharp_extended').telescope_lsp_implementation()<cr>" {:noremap true}))
                                          :cmd ["omnisharp"]})
              (vim.lsp.enable :omnisharp)

              ;; Fsharp
              (let [fsharp (require :ionide)]
                (fsharp.setup {:autostart true
                               :flags {:debounce_text_changes 150}
                               :on_attach on_attach
                               :handlers handlers
                               :before_init before_init}))

              ;; JavaScript and TypeScript
              (vim.lsp.enable :ts_ls)

              ;; html / css / json
              (vim.lsp.config :cssls {:cmd ["vscode-css-language-server" "--stdio"]})
              (vim.lsp.enable :cssls)

              (vim.lsp.config :html {:cmd ["vscode-html-language-server" "--stdio"]})
              (vim.lsp.enable :html)

              (vim.lsp.config :jsonls {:cmd ["vscode-json-language-server" "--stdio"]})
              (vim.lsp.enable :jsonls)

              ;; go
              (vim.lsp.enable :gopls)

              ;; dart
              (vim.lsp.enable :dartls)))}]
