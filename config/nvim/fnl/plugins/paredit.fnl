[{1 :julienvincent/nvim-paredit
  :lazy true
  :ft [:clojure :fennel]
  :config (fn []
            (let [paredit (require :nvim-paredit)]
              (paredit.setup
                {:keys {:<localleader>I [(fn []
                                           (paredit.cursor.place_cursor
                                             (paredit.wrap.wrap_enclosing_form_under_cursor "(" ")")
                                             {:mode :insert
                                              :placement :inner_end}))
                                         "Wrap form insert tail"]

                        :<localleader>W [(fn []
                                           (paredit.cursor.place_cursor
                                             (paredit.wrap.wrap_element_under_cursor "(" ")")
                                             {:mode :insert
                                              :placement :inner_end}))
                                         "Wrap element insert tail"]

                        :<localleader>i [(fn []
                                           (paredit.cursor.place_cursor
                                             (paredit.wrap.wrap_enclosing_form_under_cursor "( " ")")
                                             {:mode :insert
                                              :placement :inner_start}))
                                         "Wrap form insert head"]

                        :<localleader>w [(fn []
                                           (paredit.cursor.place_cursor
                                             (paredit.wrap.wrap_element_under_cursor "( " ")")
                                             {:mode :insert
                                              :placement :inner_start}))
                                         "Wrap element insert head"]}})))}

 {1 :julienvincent/nvim-paredit-fennel
  :dependencies [:julienvincent/nvim-paredit]
  :lazy true
  :ft [:fennel]
  :config (fn []
            (let [paredit-fnl (require :nvim-paredit-fennel)]
              (paredit-fnl.setup)))}

 {1 :kylechui/nvim-surround
  :event "VeryLazy"
  :config (fn []
            (let [surround (require :nvim-surround)]
              (surround.setup)))}

 {1 :windwp/nvim-autopairs
  :event "InsertEnter"
  :opts {}}]
