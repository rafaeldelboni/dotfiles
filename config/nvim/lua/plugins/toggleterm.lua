-- [nfnl] Compiled from fnl/plugins/toggleterm.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local toggleterm = require("toggleterm")
  return toggleterm.setup({open_mapping = "<leader>to", direction = "vertical", size = 120, shade_terminals = true, start_in_insert = true, insert_mappings = false, terminal_mappings = false})
end
local function _2_()
  vim.keymap.set("n", "<leader>tl", ":TermSelect<CR>", {noremap = true})
  vim.keymap.set("t", "<esc>", "<c-\\><c-n>")
  vim.keymap.set("t", "<c-h>", "<c-\\><c-n><c-w>h")
  vim.keymap.set("t", "<c-j>", "<c-\\><c-n><c-w>j")
  vim.keymap.set("t", "<c-k>", "<c-\\><c-n><c-w>k")
  return vim.keymap.set("t", "<c-l>", "<c-\\><c-n><c-w>l")
end
return {{"akinsho/toggleterm.nvim", config = _1_, init = _2_}}
