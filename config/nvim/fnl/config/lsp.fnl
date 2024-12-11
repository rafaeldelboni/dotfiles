; shared configuration

(local handlers
  {"textDocument/publishDiagnostics"
   (vim.lsp.with
     vim.lsp.diagnostic.on_publish_diagnostics
     {:severity_sort true
      :update_in_insert true
      :underline true
      :virtual_text false})
   "textDocument/hover"
   (vim.lsp.with
     vim.lsp.handlers.hover
     {:border "single"})
   "textDocument/signatureHelp"
   (vim.lsp.with
     vim.lsp.handlers.signature_help
     {:border "single"})})

(fn before_init [params]
  (set params.workDoneToken :1))

(fn on_attach [client bufnr]
  (do
    (vim.api.nvim_buf_set_keymap bufnr :n :gd "<Cmd>lua vim.lsp.buf.definition()<CR>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :K "<Cmd>lua vim.lsp.buf.hover()<CR>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>ld "<Cmd>lua vim.lsp.buf.declaration()<CR>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lt "<cmd>lua vim.lsp.buf.type_definition()<CR>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lh "<cmd>lua vim.lsp.buf.signature_help()<CR>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>ln "<cmd>lua vim.lsp.buf.rename()<CR>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>le "<cmd>lua vim.diagnostic.open_float()<CR>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lq "<cmd>lua vim.diagnostic.setloclist()<CR>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lf "<cmd>lua vim.lsp.buf.format()<CR>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lj "<cmd>lua vim.diagnostic.goto_next()<CR>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lk "<cmd>lua vim.diagnostic.goto_prev()<CR>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>la "<cmd>lua vim.lsp.buf.code_action()<CR>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :v :<leader>la "<cmd>lua vim.lsp.buf.range_code_action()<CR> " {:noremap true})
    ;telescope
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lw ":lua require('telescope.builtin').diagnostics()<cr>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lr ":lua require('telescope.builtin').lsp_references()<cr>" {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>li ":lua require('telescope.builtin').lsp_implementations()<cr>" {:noremap true})))

;lsp loading progress

(var progress-message {:status "" :percent 0 :msg ""})

(fn get-progress-message []
  progress-message)

(fn progress-handler [_ msg info]
  (let [client (vim.lsp.get_client_by_id info.client_id)] 
    (when client 
      (set progress-message.status msg.value.kind)
      (when (not= msg.value.percentage nil)
        (set progress-message.percent msg.value.percentage))
      (if 
        (and (not= msg.value.message nil) 
             (and (not= msg.token nil)
                  (not= (type (tonumber msg.token)) "number")))
        (set progress-message.msg (.. msg.token " : " msg.value.message))

        (not= msg.value.message nil)
        (set progress-message.msg msg.value.message)

        (not= msg.token nil)
        (set progress-message.msg msg.token)))))

(fn setup-progress-handler []
  (let [original-handler (. vim.lsp.handlers :$/progress)]
    (tset vim.lsp.handlers :$/progress
          (fn [...]
            (let [args (vim.F.pack_len ...)]
              (progress-handler (vim.F.unpack_len args))
              (original-handler ...))))))

(setup-progress-handler)

{: on_attach
 : handlers
 : before_init
 : get-progress-message}
