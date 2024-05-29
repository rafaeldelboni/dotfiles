-- [nfnl] Compiled from fnl/plugins/toggleterm.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local toggleterm = require("toggleterm")
  return toggleterm.setup({open_mapping = "<leader>to", direction = "vertical", size = 120, shade_terminals = true, start_in_insert = true, terminal_mappings = false, insert_mappings = false})
end
local function _3_()
  vim.keymap.set("n", "<leader>tl", ":TermSelect<CR>", {noremap = true})
  vim.keymap.set("t", "<esc>", "<c-\\><c-n>")
  vim.keymap.set("t", "<c-h>", "<c-\\><c-n><c-w>h")
  vim.keymap.set("t", "<c-j>", "<c-\\><c-n><c-w>j")
  vim.keymap.set("t", "<c-k>", "<c-\\><c-n><c-w>k")
  return vim.keymap.set("t", "<c-l>", "<c-\\><c-n><c-w>l")
end
return {{"akinsho/toggleterm.nvim", config = _2_, init = _3_}}
