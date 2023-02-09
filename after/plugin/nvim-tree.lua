local nvim_tree = require("nvim-tree")

nvim_tree.setup({
  hijack_cursor = true,
  sync_root_with_cwd = true,
  --  disable_netrw = true,
  --  hijack_netrw = true,
  view = {
    number = true,
    relativenumber = true,
    adaptive_size = true,
  },
  renderer = {
    full_name = true,
    group_empty = true,
    indent_markers = {
      enable = true,
    },
    -- icons = {
    --   git_placement = "signcolumn",
    -- },
  },
  filters = {
    dotfiles = false,
    custom = {
      "^.git$",
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = { "help" },
  },
})
