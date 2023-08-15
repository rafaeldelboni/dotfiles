-- [nfnl] Compiled from fnl/plugins/toggleterm.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local toggleterm = require("toggleterm")
  return toggleterm.setup({open_mapping = "<leader>to", direction = "vertical", size = 120, shade_terminals = true, start_in_insert = true, insert_mappings = false, terminal_mappings = false})
end
local function _3_()
  nvim.set_keymap("n", "<leader>tl", ":TermSelect<CR>", {noremap = true})
  nvim.ex.tnoremap("<esc>", "<c-\\><c-n>")
  nvim.ex.tnoremap("<c-h>", "<c-\\><c-n><c-w>h")
  nvim.ex.tnoremap("<c-j>", "<c-\\><c-n><c-w>j")
  nvim.ex.tnoremap("<c-k>", "<c-\\><c-n><c-w>k")
  return nvim.ex.tnoremap("<c-l>", "<c-\\><c-n><c-w>l")
end
return {{"akinsho/toggleterm.nvim", config = _2_, init = _3_}}
