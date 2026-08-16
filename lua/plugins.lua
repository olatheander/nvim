-- [[ Configure and install plugins ]]
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/lewis6991/gitsigns.nvim",
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/f-person/git-blame.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/rafamadriz/friendly-snippets",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("*"),
  },
  {
    src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
    version = vim.version.range("3"),
  },
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/mfussenegger/nvim-jdtls",
  {
    src = "https://github.com/iamcco/markdown-preview.nvim",
    build = "cd app && npx --yes yarn install",
  },
  "https://github.com/folke/trouble.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/nvim-neotest/neotest-jest",
  "https://github.com/marilari88/neotest-vitest",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/mfussenegger/nvim-dap-python",
  "https://github.com/gbprod/yanky.nvim",
  "https://github.com/chentoast/marks.nvim",
  "https://github.com/dangooddd/pyrepl.nvim",
})

require("mini.icons").setup({})
MiniIcons.mock_nvim_web_devicons()
-- MiniIcons.tweak_lsp_kind() -- activating this messes up the fzf-lua symbol_fmt ued by the symbol piceker configured below but adds icons to the completion picker.
require("fzf-lua").setup({
  defaults = {
    cwd_prompt = false,
  },
  lsp = {
    symbols = {
      symbol_fmt = function(s)
        return s:lower() .. "\t"
      end,
      child_prefix = false,
    },
  },
})
require("fzf-lua").register_ui_select()
local ai = require("mini.ai")
require("mini.ai").setup({
  n_lines = 500,
  custom_textobjects = {
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
    o = ai.gen_spec.treesitter({
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }),
  },
})
require("mini.comment").setup({
  options = {
    -- Use {/* */} when commenting inside JSX elements, // elsewhere
    custom_commentstring = function(ref_position)
      local ft = vim.bo.filetype
      if ft == "typescriptreact" or ft == "javascriptreact" then
        local node = vim.treesitter.get_node({ pos = { ref_position[1] - 1, ref_position[2] } })
        while node do
          local t = node:type()
          if t == "jsx_element" or t == "jsx_fragment" then
            return "{/* %s */}"
          end
          -- Stop climbing at code boundaries where // is correct
          if t == "jsx_self_closing_element" or t == "jsx_attribute" or t == "statement_block" then
            break
          end
          node = node:parent()
        end
      end
      return nil
    end,
  },
})
require("mini.move").setup({})
require("mini.surround").setup({
  mappings = {
    add = "gsa",
    delete = "gsd",
    find = "gsf",
    find_left = "gsF",
    highlight = "gsh",
    replace = "gsr",
    suffix_last = "l",
    suffix_next = "n",
  },
})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
-- require("mini.completion").setup({}) -- trying out blink.cmp for a bit.
require("mini.tabline").setup({})
require("mini.statusline").setup({})
require("oil").setup({
  default_file_explorer = false, -- Let neo-tree handle directory buffers
  columns = {
    "permissions",
    "icon",
  },
  view_options = {
    show_hidden = true,
  },
})
require("neo-tree").setup({
  close_if_last_window = true,
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
  },
  window = {
    mappings = {
      ["<space>"] = "none", -- to allow <leader>-prefixed actions to be performed when tree has focus.
      ["l"] = "open",
      ["h"] = "close_node",
      ["Y"] = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.fn.setreg("+", path)
        vim.notify("Copied: " .. path)
      end,
    },
  },
})
require("gitsigns").setup({
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
    end

        -- stylua: ignore start
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
  end,
})
require("nvim-treesitter-textobjects").setup({})
require("mason").setup({})
require("gitblame").setup({})
require("lint").linters_by_ft = {
  sh = { "shellcheck" },
  markdown = { "markdownlint" },
  python = { "mypy", "ruff" },
}
require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = { auto_show = false },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
})
require("flash").setup({})
require("yanky").setup({
  highlight = { timer = 150 },
})
require("marks").setup({})
require("which-key").setup({
  spec = {
    { "<leader>b", group = "buffers" },
    { "<leader>c", group = "code" },
    { "<leader>cx", group = "extract" },
    { "<leader>d", group = "debug" },
    { "<leader>f", group = "file/find" },
    { "<leader>g", group = "git" },
    { "<leader>gh", group = "hunks" },
    { "<leader>j", group = "PyRepl" },
    { "<leader>p", group = "yank history" },
    { "<leader>s", group = "search" },
    { "<leader>t", group = "test" },
    { "<leader>u", group = "ui" },
    { "<leader>w", group = "windows" },
    { "<leader>x", group = "diagnostics/quickfix" },
    { "<leader>y", group = "yank path" },
    { "[", group = "prev" },
    { "]", group = "next" },
    { "g", group = "goto" },
    { "gr", group = "lsp" },
    { "gs", group = "surround" },
  },
})
require("snacks").setup({})
require("trouble").setup({})
require("neotest").setup({
  adapters = {
    require("neotest-vitest")({}),
    require("neotest-jest")({}),
  },
})
