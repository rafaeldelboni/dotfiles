;; only use treesitter indent if indents.scm query exists for this language
;; falls back to neovim's built-in indentation otherwise
(fn treesitter-indent [lang]
  (let [has-indent-query (vim.treesitter.query.get lang "indents")]
    (when has-indent-query
      (set vim.bo.indentexpr "v:lua.require'nvim-treesitter'.indentexpr()"))))

;; validate lang from buffer and start treesitter
(fn start-treesitter []
  (let [buf (vim.api.nvim_get_current_buf)
        lang (vim.treesitter.language.get_lang vim.bo.filetype)
        ok (pcall vim.treesitter.start buf lang)]
    (when (and lang ok)
      (treesitter-indent lang))))

;; treesitter highlighting and indentation
(vim.api.nvim_create_autocmd
  [:FileType]
  {:pattern [:*]
   :callback start-treesitter})

;; requires tree-sitter-cli (0.26.1 or later, installed via your package manager, not npm)
[{1 :nvim-treesitter/nvim-treesitter
  :build ":TSUpdate"
  :lazy false
  :config (fn []
            (let [treesitter (require :nvim-treesitter)]
              (treesitter.install [:bash
                                   :clojure
                                   :commonlisp
                                   :dockerfile
                                   :elixir
                                   :fennel
                                   :go
                                   :html
                                   :java
                                   :javascript
                                   :typescript
                                   :json
                                   :lua
                                   :markdown
                                   :nix
                                   :ocaml
                                   :rust
                                   :yaml
                                   :zig])))}]
