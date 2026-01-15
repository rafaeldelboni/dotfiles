-- [nfnl] fnl/plugins/telescope.fnl
local custom_actions = {}
local function multi_open(prompt_bufnr, method)
  local action_state = require("telescope.actions.state")
  local actions = require("telescope.actions")
  local pickers = require("telescope.pickers")
  local picker = action_state.get_current_picker(prompt_bufnr)
  local _ = actions.add_selection(prompt_bufnr)
  local multi_selection = picker:get_multi_selection()
  local cmd_map = {default = "edit", horizontal = "split", tab = "tabe", vertical = "vsplit"}
  if (#multi_selection > 1) then
    pickers.on_close_prompt(prompt_bufnr)
    pcall(vim.api.nvim_set_current_win, picker.original_win_id)
    for i, entry in ipairs(multi_selection) do
      local cmd = (((i == 1) and "edit") or cmd_map[method])
      vim.cmd(string.format("%s %s", cmd, entry.value))
    end
    return nil
  else
    return actions[("select_" .. method)](prompt_bufnr)
  end
end
custom_actions.multi_selection_open_vsplit = function(prompt_bufnr)
  return multi_open(prompt_bufnr, "vertical")
end
custom_actions.multi_selection_open_split = function(prompt_bufnr)
  return multi_open(prompt_bufnr, "horizontal")
end
custom_actions.multi_selection_open_tab = function(prompt_bufnr)
  return multi_open(prompt_bufnr, "tab")
end
custom_actions.multi_selection_open = function(prompt_bufnr)
  return multi_open(prompt_bufnr, "default")
end
local function _2_()
  vim.keymap.set("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<CR>", {noremap = true})
  vim.keymap.set("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<CR>", {noremap = true})
  vim.keymap.set("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<CR>", {noremap = true})
  return vim.keymap.set("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<CR>", {noremap = true})
end
local function _3_()
  local telescope = require("telescope")
  local themes = require("telescope.themes")
  local actions = require("telescope.actions")
  local mappings = {["<C-J>"] = actions.move_selection_next, ["<C-K>"] = actions.move_selection_previous, ["<C-DOWN>"] = actions.cycle_history_next, ["<C-UP>"] = actions.cycle_history_prev, ["<C-S>"] = custom_actions.multi_selection_open_split, ["<C-T>"] = custom_actions.multi_selection_open_tab, ["<C-V>"] = custom_actions.multi_selection_open_vsplit, ["<CR>"] = custom_actions.multi_selection_open, ["<ESC>"] = actions.close, ["<C-TAB>"] = (actions.toggle_selection + actions.move_selection_next), ["<S-TAB>"] = (actions.toggle_selection + actions.move_selection_previous), ["<TAB>"] = actions.toggle_selection}
  telescope.setup({defaults = {mappings = {i = mappings, n = mappings}, file_ignore_patterns = {"node_modules"}, vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--iglob", "!.git", "--hidden"}}, extensions = {["ui-select"] = {themes.get_dropdown({})}}, pickers = {find_files = {find_command = {"rg", "--files", "--iglob", "!.git", "--hidden"}}}})
  return telescope.load_extension("ui-select")
end
return {{"nvim-telescope/telescope.nvim", dependencies = {"nvim-telescope/telescope-ui-select.nvim", "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}, init = _2_, config = _3_}}
