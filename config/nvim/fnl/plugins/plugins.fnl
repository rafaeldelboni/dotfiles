[; git helper
 {1 :tpope/vim-fugitive}

 ; commeting code
 {1 :numToStr/Comment.nvim
  :opts {:toggler {:line "<leader>cc"
                   :block "<leader>cb"}
         :opleader {:line "<leader>cc"
                    :block "<leader>cb"}
         :extra {:above "<leader>cO"
                 :below "<leader>co"
                 :eol "<leader>cA"}}}

 ; multicursor selector
 {1 :mg979/vim-visual-multi}

 ; fennel indent
 {1 :bakpakin/fennel.vim
  :lazy true
  :ft [:fennel]}

 ; jannet
 {1 :bakpakin/janet.vim
  :lazy true
  :ft [:janet]}]
