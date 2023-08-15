(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :guns/vim-sexp
  :dependencies [:tpope/vim-sexp-mappings-for-regular-people
                 :kylechui/nvim-surround]
  :lazy true
  :ft [:clojure :scheme :lisp :timl :fennel :janet]
  :config (fn []
            (let [surround (require :nvim-surround)]
              (surround.setup)))
  :init (fn []
          ;disables swap element colides with tmux sizing
          (set nvim.g.sexp_mappings {:sexp_swap_element_backward ""
                                     :sexp_swap_element_forward ""
                                     :sexp_swap_list_backward ""
                                     :sexp_swap_list_forward ""})
          (set nvim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet"))}]
