-- [nfnl] fnl/plugins/plugins.fnl
local function _1_()
  vim.keymap.set("n", "<leader>np", ":NoNeckPain<CR>", {noremap = true})
  vim.keymap.set("n", "<leader>ns", ":NoNeckPainScratchPad<CR>", {noremap = true})
  local no_neck_pain = require("no-neck-pain")
  return no_neck_pain.setup({width = 140, buffers = {colors = {background = "tokyonight-night", blend = -0.05}}})
end
return {{"tpope/vim-fugitive", dependencies = {"tpope/vim-rhubarb"}}, {"numToStr/Comment.nvim", opts = {toggler = {line = "<leader>cc", block = "<leader>cb"}, opleader = {line = "<leader>cc", block = "<leader>cb"}, extra = {above = "<leader>cO", below = "<leader>co", eol = "<leader>cA"}}}, {"shortcuts/no-neck-pain.nvim", config = _1_}, {"mg979/vim-visual-multi"}, {"bakpakin/fennel.vim", lazy = true, ft = {"fennel"}}, {"bakpakin/janet.vim", lazy = true, ft = {"janet"}}}
