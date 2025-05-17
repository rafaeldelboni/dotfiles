-- [nfnl] fnl/plugins/flutter.fnl
local function _1_()
  local flutter_tools = require("flutter-tools")
  local config_lsp = require("config.lsp")
  return flutter_tools.setup({lsp = {on_attach = config_lsp.on_attach, handlers = config_lsp.handlers, before_init = config_lsp.before_init}})
end
return {{"nvim-flutter/flutter-tools.nvim", lazy = true, ft = {"dart", "flutter"}, config = _1_, dependencies = {"nvim-lua/plenary.nvim"}}}
