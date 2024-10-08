-- [nfnl] Compiled from fnl/plugins/fsharp.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.g["fsharp#lsp_auto_setup"] = false
  vim.g["fsharp#lsp_codelens"] = false
  vim.g["fsharp#fsi_keymap"] = "custom"
  vim.g["fsharp#fsi_keymap_send"] = "<localleader>e"
  vim.g["fsharp#fsi_keymap_toggle"] = "<localleader>l"
  return nil
end
return {{"ionide/Ionide-vim", lazy = true, ft = {"fsharp", "fs", "fsi", "fsx", "fsscript", "fsproj"}, init = _1_}}
