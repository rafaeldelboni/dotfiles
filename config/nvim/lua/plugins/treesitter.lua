-- [nfnl] fnl/plugins/treesitter.fnl
local function _1_()
  local treesitter = require("nvim-treesitter.configs")
  return treesitter.setup({highlight = {enable = true}, indent = {enable = true}, ensure_installed = {"bash", "c_sharp", "clojure", "commonlisp", "dockerfile", "fennel", "fsharp", "gdscript", "go", "html", "java", "javascript", "json", "lua", "markdown", "yaml", "zig"}})
end
return {{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _1_}}
