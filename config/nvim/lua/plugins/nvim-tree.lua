-- [nfnl] Compiled from fnl/plugins/nvim-tree.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local tree = require("nvim-tree")
  local on_attach
  local function on_attach0(bufnr)
    local api = require("nvim-tree.api")
    local opts
    local function _2_(desc)
      return {buffer = bufnr, desc = ("nvim-tree: " .. desc), noremap = true, nowait = true, silent = true}
    end
    opts = _2_
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set("n", "U", api.tree.change_root_to_node, opts("CD"))
    return vim.keymap.set("n", "u", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
  end
  on_attach = on_attach0
  return tree.setup({on_attach = on_attach, sort_by = "case_sensitive", view = {adaptive_size = true}, renderer = {group_empty = true, indent_markers = {enable = false}, icons = {git_placement = "after", glyphs = {bookmark = "\239\145\186", folder = {default = "\239\132\148", open = "\239\132\149"}}, webdev_colors = false}}, filters = {custom = {"^\\.git$"}}})
end
local function _3_()
  vim.cmd("hi NvimTreeSpecialFile ctermfg=7 guifg=#c6c6c6")
  vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>", {noremap = true})
  vim.keymap.set("n", "<leader>tf", ":NvimTreeFocus<CR>", {noremap = true})
  vim.keymap.set("n", "<leader>tc", ":NvimTreeCollapse<CR>", {noremap = true})
  return vim.keymap.set("n", "<leader>tr", ":NvimTreeFindFile<CR>", {noremap = true})
end
return {{"nvim-tree/nvim-tree.lua", branch = "master", config = _1_, init = _3_}}
