(module config.plugin.sexp
  {autoload {nvim aniseed.nvim}})

;disables swap element colides with tmux sizing
(set nvim.g.sexp_mappings {:sexp_swap_element_backward ""
                           :sexp_swap_element_forward ""
                           :sexp_swap_list_backward ""
                           :sexp_swap_list_forward ""})

(set nvim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet")
