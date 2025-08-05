[; git helper
 {1 :tpope/vim-fugitive
  :dependencies [:tpope/vim-rhubarb]}

 ; commeting code
 {1 :numToStr/Comment.nvim
  :opts {:toggler {:line "<leader>cc"
                   :block "<leader>cb"}
         :opleader {:line "<leader>cc"
                    :block "<leader>cb"}
         :extra {:above "<leader>cO"
                 :below "<leader>co"
                 :eol "<leader>cA"}}}

 ; center buffers
 {1 :shortcuts/no-neck-pain.nvim
  :config (fn []
            (vim.keymap.set :n :<leader>np ":NoNeckPain<CR>" {:noremap true})
            (vim.keymap.set :n :<leader>ns ":NoNeckPainScratchPad<CR>" {:noremap true})
            (let [no-neck-pain (require :no-neck-pain)]
              (no-neck-pain.setup
                {:width 140
                 :buffers {:colors {:background "tokyonight-night"
                                    :blend -0.05}}})))}

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
