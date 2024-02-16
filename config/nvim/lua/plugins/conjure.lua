-- [nfnl] Compiled from fnl/plugins/conjure.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  vim.cmd({cmd = "command", args = {"-nargs=1", "Cjc", "ConjureConnect", "<args>"}, bang = true})
  vim.cmd({cmd = "command", args = {"-nargs=1", "Cjss", "ConjureShadowSelect", "<args>"}, bang = true})
  nvim.g["conjure#mapping#doc_word"] = "K"
  nvim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
  nvim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
  nvim.g["conjure#client#clojure#nrepl#test#current_form_names"] = {"deftest", "defflow", "defspec", "describe"}
  return nil
end
return {{"Olical/conjure", branch = "master", init = _2_}}
