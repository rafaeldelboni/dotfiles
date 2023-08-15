-- [nfnl] Compiled from fnl/config/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
nvim.set_keymap("n", "<space>", "<nop>", {noremap = true})
nvim.set_keymap("n", "<CR>", ":noh<CR><CR>", {noremap = true})
nvim.set_keymap("n", "<C-w>T", ":tab split<CR>", {noremap = true, silent = true})
nvim.set_keymap("t", "<esc><esc>", "<c-\\><c-n>", {noremap = true})
return {}
