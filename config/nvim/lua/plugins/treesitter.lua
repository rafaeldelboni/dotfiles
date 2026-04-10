-- [nfnl] fnl/plugins/treesitter.fnl
local function treesitter_indent(lang)
  local has_indent_query = vim.treesitter.query.get(lang, "indents")
  if has_indent_query then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    return nil
  else
    return nil
  end
end
local function start_treesitter()
  local buf = vim.api.nvim_get_current_buf()
  local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
  local ok = pcall(vim.treesitter.start, buf, lang)
  if (lang and ok) then
    return treesitter_indent()
  else
    return nil
  end
end
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"*"}, callback = start_treesitter})
local function _3_()
  local treesitter = require("nvim-treesitter")
  return treesitter.install({"bash", "clojure", "commonlisp", "dockerfile", "elixir", "fennel", "go", "html", "java", "javascript", "typescript", "json", "lua", "markdown", "nix", "ocaml", "rust", "yaml", "zig"})
end
return {{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _3_, lazy = false}}
