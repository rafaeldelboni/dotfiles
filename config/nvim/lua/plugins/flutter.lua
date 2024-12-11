-- [nfnl] Compiled from fnl/plugins/flutter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local flutter_tools = require("flutter-tools")
  local cmplsp = require("cmp_nvim_lsp")
  local config_lsp = require("config.lsp")
  return flutter_tools.setup({lsp = {on_attach = config_lsp.on_attach, handlers = config_lsp.handlers, before_init = config_lsp.before_init, capabilities = cmplsp.default_capabilities()}})
end
return {{"nvim-flutter/flutter-tools.nvim", lazy = true, ft = {"dart", "flutter"}, config = _1_, dependencies = {"nvim-lua/plenary.nvim"}}}
