-- [nfnl] fnl/plugins/tmux.fnl
local function _1_()
  local tmux = require("tmux")
  return tmux.setup({copy_sync = {redirect_to_clipboard = true}})
end
return {{"aserowy/tmux.nvim", config = _1_}}
