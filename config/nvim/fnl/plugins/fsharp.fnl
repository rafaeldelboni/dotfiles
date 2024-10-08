[{1 :ionide/Ionide-vim
  :lazy true
  :ft [:fsharp :fs :fsi :fsx :fsscript :fsproj]
  :init (fn []
          (set vim.g.fsharp#lsp_auto_setup false)
          (set vim.g.fsharp#lsp_codelens false)
          (set vim.g.fsharp#fsi_keymap :custom)
          (set vim.g.fsharp#fsi_keymap_send :<localleader>e)
          (set vim.g.fsharp#fsi_keymap_toggle :<localleader>l))}]
