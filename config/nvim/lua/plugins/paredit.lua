-- [nfnl] Compiled from fnl/plugins/paredit.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local paredit = require("nvim-paredit")
  local function _2_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_enclosing_form_under_cursor("(", ")"), {mode = "insert", placement = "inner_end"})
  end
  local function _3_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_element_under_cursor("(", ")"), {mode = "insert", placement = "inner_end"})
  end
  local function _4_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_enclosing_form_under_cursor("( ", ")"), {mode = "insert", placement = "inner_start"})
  end
  local function _5_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_element_under_cursor("( ", ")"), {mode = "insert", placement = "inner_start"})
  end
  return paredit.setup({keys = {["<localleader>I"] = {_2_, "Wrap form insert tail"}, ["<localleader>W"] = {_3_, "Wrap element insert tail"}, ["<localleader>i"] = {_4_, "Wrap form insert head"}, ["<localleader>w"] = {_5_, "Wrap element insert head"}}})
end
local function _6_()
  local surround = require("nvim-surround")
  return surround.setup()
end
return {{"julienvincent/nvim-paredit", lazy = true, ft = {"clojure", "fennel", "scheme", "lisp"}, config = _1_}, {"kylechui/nvim-surround", event = "VeryLazy", config = _6_}, {"windwp/nvim-autopairs", event = "InsertEnter", opts = {}}}
