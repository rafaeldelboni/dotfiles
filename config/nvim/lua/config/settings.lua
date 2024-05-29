-- [nfnl] Compiled from fnl/config/settings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local str = autoload("nfnl.string")
local core = autoload("nfnl.core")
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter"}, {pattern = {"*"}, command = "checktime"})
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"rust"}, command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab"})
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"cs"}, command = "setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab"})
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"gdscript", "gdshader"}, command = "setlocal foldmethod=expr tabstop=4 shiftwidth=4 indentexpr= noexpandtab"})
vim.wo.wrap = false
do
  local options = {encoding = "utf-8", spelllang = "en_us", backspace = "2", colorcolumn = "80", errorbells = true, number = true, ruler = true, completeopt = "menuone,noselect", wildmenu = true, wildignore = "*/tmp/*,*.so,*.swp,*.zip", ignorecase = true, smartcase = true, clipboard = "unnamedplus", list = true, listchars = str.join(",", {"tab:\226\150\182-", "trail:\226\128\162", "extends:\194\187", "precedes:\194\171", "eol:\194\172"}), expandtab = true, tabstop = 2, shiftwidth = 2, softtabstop = 2, undofile = true, splitbelow = true, splitright = true, hlsearch = true, signcolumn = "number", backup = false, showmode = false, swapfile = false}
  for option, value in pairs(options) do
    core.assoc(vim.o, option, value)
  end
end
return {}
