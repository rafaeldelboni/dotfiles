-- [nfnl] Compiled from fnl/plugins/conjure.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.cmd({cmd = "command", args = {"-nargs=1", "Cjc", "ConjureConnect", "<args>"}, bang = true})
  vim.cmd({cmd = "command", args = {"-nargs=1", "Cjss", "ConjureShadowSelect", "<args>"}, bang = true})
  vim.g["conjure#mapping#doc_word"] = "K"
  vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
  vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
  vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = {"deftest", "defflow", "defspec", "describe"}
  return nil
end
return {{"Olical/conjure", branch = "main", init = _1_}}
