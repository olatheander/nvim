local actions = require("telescope.actions")
local telescope = require("telescope")
-- local builtin = require('telescope.builtin')

-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>ps', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ")})
-- end)

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      },
    },
    file_ignore_patterns = { ".git/" },
  },
  pickers = {
    live_grep = {
      additional_args = function(opts)
        return { "--hidden" }
      end,
    },
  },
})
