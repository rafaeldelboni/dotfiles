(module config.plugin.compe
  {autoload {nvim aniseed.nvim
             compe compe}})

;; Setup compe with desired settings
(compe.setup {:enabled       true
              :autocomplete  true
              :min_length    1
              :documentation true
              :preselect "enable"
              :documentation {:winhighlight "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder"
                              :border "single"}
              :source {:spell false
                       :path true
                       :buffer true
                       :vsnip true
                       :nvim_lsp true
                       :conjure true
                       :treesitter true
                       :tags true}})

;; Setup keybindings for compe's autocompletion menu
(nvim.set_keymap :i :<C-Space> "compe#complete()" {:noremap true :silent true :expr true})
(nvim.set_keymap :i :<CR> "compe#confirm('<CR>')" {:noremap true :silent true :expr true})
(nvim.set_keymap :i :<C-e> "compe#close('<C-e>')" {:noremap true :silent true :expr true})
