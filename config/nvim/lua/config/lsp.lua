-- [nfnl] fnl/config/lsp.fnl
local handlers
local function _1_(err, result, ctx, config)
  config.border = "single"
  return vim.lsp.handlers.hover(err, result, ctx, nil)
end
local function _2_(err, result, ctx, config)
  config.border = "single"
  return vim.lsp.handlers.signature_help(err, result, ctx, nil)
end
handlers = {["textDocument/hover"] = _1_, ["textDocument/signatureHelp"] = _2_}
local function before_init(params)
  params.workDoneToken = "1"
  return nil
end
local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ld", "<Cmd>lua vim.lsp.buf.declaration()<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>la", "<cmd>lua vim.lsp.buf.range_code_action()<CR> ", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lw", ":lua require('telescope.builtin').diagnostics()<cr>", {noremap = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", ":lua require('telescope.builtin').lsp_references()<cr>", {noremap = true})
  return vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>li", ":lua require('telescope.builtin').lsp_implementations()<cr>", {noremap = true})
end
local progress_message = {status = "", percent = 0, msg = ""}
local function get_progress_message()
  return progress_message
end
local function progress_handler(_, msg, info)
  local client = vim.lsp.get_client_by_id(info.client_id)
  if client then
    progress_message.status = msg.value.kind
    if (msg.value.percentage ~= nil) then
      progress_message.percent = msg.value.percentage
    else
    end
    if ((msg.value.message ~= nil) and ((msg.token ~= nil) and (type(tonumber(msg.token)) ~= "number"))) then
      progress_message.msg = (msg.token .. " : " .. msg.value.message)
      return nil
    elseif (msg.value.message ~= nil) then
      progress_message.msg = msg.value.message
      return nil
    elseif (msg.token ~= nil) then
      progress_message.msg = msg.token
      return nil
    else
      return nil
    end
  else
    return nil
  end
end
local function setup_progress_handler()
  local original_handler = vim.lsp.handlers["$/progress"]
  local function _6_(...)
    local args = vim.F.pack_len(...)
    progress_handler(vim.F.unpack_len(args))
    return original_handler(...)
  end
  vim.lsp.handlers["$/progress"] = _6_
  return nil
end
setup_progress_handler()
return {on_attach = on_attach, handlers = handlers, before_init = before_init, ["get-progress-message"] = get_progress_message}
