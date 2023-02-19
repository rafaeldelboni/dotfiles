(module config.plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs}})

(treesitter.setup {:highlight {:enable true}
                   :indent {:enable true}
                   :ensure_installed [:bash
                                      :c
                                      :c_sharp
                                      :clojure
                                      :cmake
                                      :commonlisp
                                      :cpp
                                      :css
                                      :dart
                                      :dockerfile
                                      :fennel
                                      :go
                                      :html
                                      :java
                                      :javascript
                                      :json
                                      :lua
                                      :markdown
                                      :python
                                      :rust
                                      :typescript
                                      :vim
                                      :yaml
                                      :zig]})
