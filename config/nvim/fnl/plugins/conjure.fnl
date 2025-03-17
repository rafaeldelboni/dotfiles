[{1 :Olical/conjure
  :branch "main"
  :init (fn []
          ; Alias for ConjureShadowSelect -> Csc
          (vim.cmd {:cmd "command" :args ["-nargs=1" "Cjc" "ConjureConnect" "<args>"] :bang true})
          (vim.cmd {:cmd "command" :args ["-nargs=1" "Cjss" "ConjureShadowSelect" "<args>"] :bang true})
          ; Some conjure settings
          (set vim.g.conjure#mapping#doc_word "K")
          (set vim.g.conjure#client#clojure#nrepl#eval#auto_require false)
          (set vim.g.conjure#client#clojure#nrepl#connection#auto_repl#enabled false)
          (set vim.g.conjure#client#clojure#nrepl#test#current_form_names ["deftest" "defflow" "defspec" "describe"]))}]
