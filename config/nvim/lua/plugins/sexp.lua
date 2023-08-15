-- [nfnl] Compiled from fnl/plugins/sexp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local surround = require("nvim-surround")
  return surround.setup()
end
local function _3_()
  nvim.g.sexp_mappings = {sexp_swap_element_backward = "", sexp_swap_element_forward = "", sexp_swap_list_backward = "", sexp_swap_list_forward = ""}
  nvim.g.sexp_filetypes = "clojure,scheme,lisp,timl,fennel,janet"
  return nil
end
return {{"guns/vim-sexp", dependencies = {"tpope/vim-sexp-mappings-for-regular-people", "kylechui/nvim-surround"}, lazy = true, ft = {"clojure", "scheme", "lisp", "timl", "fennel", "janet"}, config = _2_, init = _3_}}
