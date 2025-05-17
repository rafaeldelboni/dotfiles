-- [nfnl] fnl/plugins/lsp.fnl
vim.diagnostic.config({signs = {text = {[vim.diagnostic.severity.ERROR] = "\239\129\151", [vim.diagnostic.severity.WARN] = "\239\129\177", [vim.diagnostic.severity.INFO] = "\239\129\154", [vim.diagnostic.severity.HINT] = "\239\129\153"}}})
local function _1_()
  local config_lsp = require("config.lsp")
  local on_attach = config_lsp.on_attach
  local handlers = config_lsp.handlers
  local before_init = config_lsp.before_init
  vim.lsp.config("*", {on_attach = on_attach, handlers = handlers, before_init = before_init})
  local function _2_(bufnr, on_dir)
    local pattern = vim.api.nvim_buf_get_name(bufnr)
    local util = require("lspconfig.util")
    local fallback = vim.loop.cwd()
    local patterns = {"project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", ".git", "bb.edn"}
    local root = util.root_pattern(patterns)(pattern)
    return on_dir((root or fallback))
  end
  vim.lsp.config("clojure_lsp", {root_dir = _2_})
  vim.lsp.enable("clojure_lsp")
  vim.lsp.enable("gdscript")
  local function _3_(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":lua require('omnisharp_extended').telescope_lsp_definition()<cr>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lt", ":lua require('omnisharp_extended').telescope_lsp_type_definition()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", ":lua require('omnisharp_extended').telescope_lsp_references()<cr>", {noremap = true})
    return vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>li", ":lua require('omnisharp_extended').telescope_lsp_implementation()<cr>", {noremap = true})
  end
  vim.lsp.config("omnisharp", {on_attach = _3_, cmd = {"omnisharp"}})
  vim.lsp.enable("omnisharp")
  do
    local fsharp = require("ionide")
    fsharp.setup({autostart = true, flags = {debounce_text_changes = 150}, on_attach = on_attach, handlers = handlers, before_init = before_init})
  end
  vim.lsp.config("ts_ls", {on_attach = on_attach, handlers = handlers, before_init = before_init})
  vim.lsp.enable("ts_ls")
  vim.lsp.config("cssls", {cmd = {"vscode-css-language-server", "--stdio"}})
  vim.lsp.enable("cssls")
  vim.lsp.config("html", {cmd = {"vscode-html-language-server", "--stdio"}})
  vim.lsp.enable("html")
  vim.lsp.config("jsonls", {cmd = {"vscode-json-language-server", "--stdio"}})
  vim.lsp.enable("jsonls")
  return vim.lsp.enable("gopls")
end
return {{"neovim/nvim-lspconfig", config = _1_}}
