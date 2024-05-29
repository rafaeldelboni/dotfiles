-- [nfnl] Compiled from fnl/plugins/tmux.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local tmux = require("tmux")
  return tmux.setup({copy_sync = {redirect_to_clipboard = true}})
end
return {{"aserowy/tmux.nvim", config = _1_}}
