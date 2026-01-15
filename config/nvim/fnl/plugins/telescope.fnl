(local custom-actions {})

(fn multi_open [prompt-bufnr method]
  (let [action-state (require :telescope.actions.state)
        actions (require :telescope.actions)
        pickers (require :telescope.pickers)
        picker (action-state.get_current_picker prompt-bufnr)
        _ (actions.add_selection prompt-bufnr)
        multi-selection (picker:get_multi_selection)
        cmd-map {:default :edit
                 :horizontal :split
                 :tab :tabe
                 :vertical :vsplit}]
    (if (> (length multi-selection) 1)
      (do
        (pickers.on_close_prompt prompt-bufnr)
        (pcall vim.api.nvim_set_current_win picker.original_win_id)
        (each [i entry (ipairs multi-selection)]
          (let [cmd (or (and (= i 1) :edit) (. cmd-map method))]
            (vim.cmd (string.format "%s %s" cmd entry.value)))))
      ((. actions (.. :select_ method)) prompt-bufnr))))

(fn custom-actions.multi_selection_open_vsplit [prompt-bufnr]
  (multi_open prompt-bufnr :vertical))

(fn custom-actions.multi_selection_open_split [prompt-bufnr]
  (multi_open prompt-bufnr :horizontal))

(fn custom-actions.multi_selection_open_tab [prompt-bufnr]
  (multi_open prompt-bufnr :tab))

(fn custom-actions.multi_selection_open [prompt-bufnr]
  (multi_open prompt-bufnr :default))

[{1 :nvim-telescope/telescope.nvim
  :dependencies [:nvim-telescope/telescope-ui-select.nvim
                 :nvim-lua/popup.nvim
                 :nvim-lua/plenary.nvim]
  :init (fn []
          (vim.keymap.set :n :<leader>ff ":lua require('telescope.builtin').find_files()<CR>" {:noremap true})
          (vim.keymap.set :n :<leader>fg ":lua require('telescope.builtin').live_grep()<CR>" {:noremap true})
          (vim.keymap.set :n :<leader>fb ":lua require('telescope.builtin').buffers()<CR>" {:noremap true})
          (vim.keymap.set :n :<leader>fh ":lua require('telescope.builtin').help_tags()<CR>" {:noremap true}))
  :config (fn []
            (let [telescope (require :telescope)
                  themes (require :telescope.themes)
                  actions (require :telescope.actions)
                  mappings {:<C-J> actions.move_selection_next
                            :<C-K> actions.move_selection_previous
                            :<C-DOWN> actions.cycle_history_next
                            :<C-UP> actions.cycle_history_prev
                            :<C-S> custom-actions.multi_selection_open_split
                            :<C-T> custom-actions.multi_selection_open_tab
                            :<C-V> custom-actions.multi_selection_open_vsplit
                            :<CR> custom-actions.multi_selection_open
                            :<ESC> actions.close
                            :<C-TAB> (+ actions.toggle_selection actions.move_selection_next)
                            :<S-TAB> (+ actions.toggle_selection actions.move_selection_previous)
                            :<TAB> actions.toggle_selection}]
              (telescope.setup {:defaults {:mappings {:i mappings
                                                      :n mappings}
                                           :file_ignore_patterns ["node_modules"]
                                           :vimgrep_arguments ["rg"
                                                               "--color=never"
                                                               "--no-heading"
                                                               "--with-filename"
                                                               "--line-number"
                                                               "--column"
                                                               "--smart-case"
                                                               "--iglob"
                                                               "!.git"
                                                               "--hidden"]}
                                :extensions {:ui-select {1 (themes.get_dropdown {})}}
                                :pickers {:find_files {:find_command ["rg"
                                                                      "--files"
                                                                      "--iglob"
                                                                      "!.git"
                                                                      "--hidden"]}}})
              (telescope.load_extension "ui-select")))}]
