-- [nfnl] Compiled from fnl/plugins/tmux.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local tmux = require("tmux")
  return tmux.setup({copy_sync = {redirect_to_clipboard = true}})
end
return {{"aserowy/tmux.nvim", config = _2_}}
