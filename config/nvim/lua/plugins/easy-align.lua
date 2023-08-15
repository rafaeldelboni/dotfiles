-- [nfnl] Compiled from fnl/plugins/easy-align.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  nvim.set_keymap("x", "<leader>ea", "<Plug>(EasyAlign)", {})
  return nvim.set_keymap("n", "<leader>ea", "<Plug>(EasyAlign)", {})
end
return {{"junegunn/vim-easy-align", init = _2_}}
