-- [nfnl] Compiled from fnl/config/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
vim.keymap.set("n", "<space>", "<nop>", {noremap = true})
vim.keymap.set("n", "<CR>", ":noh<CR><CR>", {noremap = true})
vim.keymap.set("n", "<C-w>T", ":tab split<CR>", {noremap = true, silent = true})
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", {noremap = true})
return {}
