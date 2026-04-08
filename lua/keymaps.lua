-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Paste & Delete to void registry
vim.keymap.set({ "n", "v" }, "<leader>p", [["_dP]], { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>z", [["_d]], { desc = "Delete to void registry" })

-- Better window navigation
vim.keymap.set("n", "<m-w>", "<C-w>w", { noremap = true, silent = true, desc = "Next window" })
vim.keymap.set("t", "<m-w>", [[<Cmd>wincmd w<CR>]], { noremap = true, silent = true, desc = "Next window" })

-- Save file
vim.keymap.set("i", "<C-\\>", [[<Cmd>w<CR><Esc>]], { desc = "Save file" }) -- C-s collides with default LSP signature_help() mapping.
vim.keymap.set("n", "<C-s>", [[<Cmd>w<CR><Esc>]], { desc = "Save file" })

-- Enable half-page jumping while keeping cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down while keeping cursor in the middle" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up while keeping cursor in the middle" })

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- commenting
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- new file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

vim.keymap.set("n", "<leader>uS", function()
  local langs = { "en_us", "sv", "en_us,sv" }
  local current = vim.o.spelllang
  for i, lang in ipairs(langs) do
    if lang == current then
      local next = langs[(i % #langs) + 1]
      vim.o.spelllang = next
      vim.notify("Spell language: " .. next)
      return
    end
  end
  vim.o.spelllang = langs[1]
  vim.notify("Spell language: " .. langs[1])
end, { desc = "Cycle Spell Language" })

----------------
--- Neotree
----------------
vim.keymap.set("n", "<leader>e", function()
  require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
end, { desc = "Explorer NeoTree (cwd)" })
vim.keymap.set("n", "<leader>ge", function()
  require("neo-tree.command").execute({ source = "git_status", toggle = true })
end, { desc = "Git Explorer" })
vim.keymap.set("n", "<leader>be", function()
  require("neo-tree.command").execute({ source = "buffers", toggle = true })
end, { desc = "Buffer Explorer" })
----------------
--- FZF
----------------
vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Switch Buffer" })
-- Grep & general
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>:", "<cmd>FzfLua command_history<cr>", { desc = "Command History" })
vim.keymap.set("n", "<leader><space>", "<cmd>FzfLua files<cr>", { desc = "Find Files (Root Dir)" })
-- find
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fB", "<cmd>FzfLua buffers<cr>", { desc = "Buffers (all)" })
vim.keymap.set("n", "<leader>fc", function()
  require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>fF", function()
  require("fzf-lua").files({ cwd = vim.uv.cwd() })
end, { desc = "Find Files (cwd)" })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua git_files<cr>", { desc = "Find Files (git-files)" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent" })
vim.keymap.set("n", "<leader>fR", function()
  require("fzf-lua").oldfiles({ cwd = vim.uv.cwd() })
end, { desc = "Recent (cwd)" })
-- git
vim.keymap.set("n", "<leader>gc", "<cmd>FzfLua git_commits<cr>", { desc = "Commits" })
vim.keymap.set("n", "<leader>gd", "<cmd>FzfLua git_diff<cr>", { desc = "Git Diff (files)" })
vim.keymap.set("n", "<leader>gl", "<cmd>FzfLua git_commits<cr>", { desc = "Commits" })
vim.keymap.set("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", { desc = "Status" })
vim.keymap.set("n", "<leader>gS", "<cmd>FzfLua git_stash<cr>", { desc = "Git Stash" })
-- search
vim.keymap.set("n", '<leader>s"', "<cmd>FzfLua registers<cr>", { desc = "Registers" })
vim.keymap.set("n", "<leader>s/", "<cmd>FzfLua search_history<cr>", { desc = "Search History" })
vim.keymap.set("n", "<leader>sa", "<cmd>FzfLua autocmds<cr>", { desc = "Auto Commands" })
vim.keymap.set("n", "<leader>sb", "<cmd>FzfLua lines<cr>", { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sc", "<cmd>FzfLua command_history<cr>", { desc = "Command History" })
vim.keymap.set("n", "<leader>sC", "<cmd>FzfLua commands<cr>", { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", "<cmd>FzfLua diagnostics_document<cr>", { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<cr>", { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>sG", function()
  require("fzf-lua").live_grep({ cwd = vim.uv.cwd() })
end, { desc = "Grep (cwd)" })
vim.keymap.set("n", "<leader>sh", "<cmd>FzfLua help_tags<cr>", { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", "<cmd>FzfLua highlights<cr>", { desc = "Search Highlight Groups" })
vim.keymap.set("n", "<leader>sj", "<cmd>FzfLua jumps<cr>", { desc = "Jumplist" })
vim.keymap.set("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>", { desc = "Key Maps" })
vim.keymap.set("n", "<leader>sl", "<cmd>FzfLua loclist<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>sM", "<cmd>FzfLua man_pages<cr>", { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sm", "<cmd>FzfLua marks<cr>", { desc = "Jump to Mark" })
vim.keymap.set("n", "<leader>sR", "<cmd>FzfLua resume<cr>", { desc = "Resume" })
vim.keymap.set("n", "<leader>sq", "<cmd>FzfLua quickfix<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>sw", "<cmd>FzfLua grep_cword<cr>", { desc = "Word (Root Dir)" })
vim.keymap.set("n", "<leader>sW", function()
  require("fzf-lua").grep_cword({ cwd = vim.uv.cwd() })
end, { desc = "Word (cwd)" })
vim.keymap.set("x", "<leader>sw", "<cmd>FzfLua grep_visual<cr>", { desc = "Selection (Root Dir)" })
vim.keymap.set("x", "<leader>sW", function()
  require("fzf-lua").grep_visual({ cwd = vim.uv.cwd() })
end, { desc = "Selection (cwd)" })
vim.keymap.set("n", "<leader>uC", "<cmd>FzfLua colorschemes<cr>", { desc = "Colorscheme with Preview" })
vim.keymap.set("n", "<leader>ss", function()
  require("fzf-lua").lsp_document_symbols()
end, { desc = "Goto Symbol" })
vim.keymap.set("n", "<leader>sS", function()
  require("fzf-lua").lsp_live_workspace_symbols()
end, { desc = "Goto Symbol (Workspace)" })

-- windows
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

----------------
--- Buffers
----------------
vim.keymap.set("n", "<leader>bd", function()
  require("mini.bufremove").delete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bnext<cr>", { noremap = true, silent = true, desc = "Next Buffer" })
vim.keymap.set("n", "<M-Tab>", "<cmd>bprevious<cr>", { noremap = true, silent = true, desc = "Previous Buffer" }) -- Use Meta/Alt not to break CTRL+i (since CTRL+i and Tab is the same thing in terminals)

----------------
--- Quickfix
----------------
vim.keymap.set("n", "<leader>xq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })
require("fzf-lua").config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"

----------------
--- Formatting
----------------
vim.keymap.set({ "n", "x" }, "<leader>cF", function()
  require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
end, { desc = "Format Injected Langs" })
vim.keymap.set({ "n", "x" }, "<leader>cf", function()
  require("conform").format({ timeout_ms = 3000 })
end, { desc = "Format" })

----------------
--- Snacks
----------------
vim.keymap.set("n", "<leader>.", function()
  Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>S", function()
  Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })
if vim.fn.executable("lazygit") == 1 then
  vim.keymap.set("n", "<leader>gg", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (cwd)" })
end
Snacks.toggle
  .new({
    name = "Auto Format (Global)",
    get = function()
      return not vim.g.disable_autoformat
    end,
    set = function(state)
      vim.g.disable_autoformat = not state
    end,
  })
  :map("<leader>uf")
Snacks.toggle
  .new({
    name = "Auto Format (Buffer)",
    get = function()
      return not vim.b.disable_autoformat
    end,
    set = function(state)
      vim.b.disable_autoformat = not state
    end,
  })
  :map("<leader>uF")
if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map("<leader>uh")
end
Snacks.toggle
  .new({
    name = "Spell Check",
    get = function()
      return vim.o.spell
    end,
    set = function(state)
      vim.o.spell = state
    end,
  })
  :map("<leader>us")
vim.keymap.set("n", "<leader>gl", function()
  Snacks.picker.git_log()
end, { desc = "Git Log (cwd)" })
vim.keymap.set("n", "<leader>gb", function()
  Snacks.picker.git_log_line()
end, { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>gf", function()
  Snacks.picker.git_log_file()
end, { desc = "Git Current File History" })
vim.keymap.set({ "n", "x" }, "<leader>gB", function()
  Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })
vim.keymap.set({ "n", "x" }, "<leader>gY", function()
  Snacks.gitbrowse({
    open = function(url)
      vim.fn.setreg("+", url)
    end,
    notify = false,
  })
end, { desc = "Git Browse (copy)" })
