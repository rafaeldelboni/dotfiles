-- [nfnl] Compiled from fnl/plugins/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
vim.diagnostic.config({signs = {text = {[vim.diagnostic.severity.ERROR] = "\239\129\151", [vim.diagnostic.severity.WARN] = "\239\129\177", [vim.diagnostic.severity.INFO] = "\239\129\154", [vim.diagnostic.severity.HINT] = "\239\129\153"}}})
local function _1_()
  local lsp = require("lspconfig")
  local cmplsp = require("cmp_nvim_lsp")
  local config_lsp = require("config.lsp")
  local on_attach = config_lsp.on_attach
  local handlers = config_lsp.handlers
  local before_init = config_lsp.before_init
  local capabilities = cmplsp.default_capabilities()
  lsp.clojure_lsp.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities})
  lsp.gdscript.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities})
  local function _2_(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":lua require('omnisharp_extended').telescope_lsp_definition()<cr>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lt", ":lua require('omnisharp_extended').telescope_lsp_type_definition()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", ":lua require('omnisharp_extended').telescope_lsp_references()<cr>", {noremap = true})
    return vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>li", ":lua require('omnisharp_extended').telescope_lsp_implementation()<cr>", {noremap = true})
  end
  lsp.omnisharp.setup({on_attach = _2_, handlers = handlers, capabilities = capabilities, cmd = {"omnisharp"}})
  do
    local fsharp = require("ionide")
    fsharp.setup({autostart = true, flags = {debounce_text_changes = 150}, on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities})
  end
  lsp.ts_ls.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities})
  lsp.cssls.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, cmd = {"vscode-css-language-server", "--stdio"}})
  lsp.html.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, cmd = {"vscode-html-language-server", "--stdio"}})
  lsp.jsonls.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, cmd = {"vscode-json-language-server", "--stdio"}})
  lsp.gopls.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities})
  return lsp.dartls.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities})
end
return {{"neovim/nvim-lspconfig", config = _1_}}
