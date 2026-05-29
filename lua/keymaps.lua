-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keep visual selection after indenting
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Delete to void registry
vim.keymap.set({ "n", "v" }, "<leader>z", [["_d]], { desc = "Delete to void registry" })

-- Yank file path to clipboard
vim.keymap.set("n", "<leader>yf", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy File Path (Relative)" })
vim.keymap.set("n", "<leader>yF", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy File Path (Absolute)" })

-- Better window navigation
vim.keymap.set("n", "<m-w>", "<C-w>w", { noremap = true, silent = true, desc = "Next window" })
vim.keymap.set("t", "<m-w>", [[<Cmd>wincmd w<CR>]], { noremap = true, silent = true, desc = "Next window" })

-- Save file
vim.keymap.set("i", "<C-\\>", [[<Cmd>w<CR><Esc>]], { desc = "Save file" }) -- C-s collides with default LSP signature_help() mapping.
vim.keymap.set("n", "<C-\\>", [[<Cmd>w<CR><Esc>]], { desc = "Save file" })
vim.keymap.set("i", "<M-\\>", [[<Cmd>wa<CR><Esc>]], { desc = "Save All Buffers" })
vim.keymap.set("n", "<M-\\>", [[<Cmd>wa<CR>]], { desc = "Save All Buffers" })

-- tmux navigator (vim.g.tmux_navigator_no_mappings disables plugin defaults)
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate Left" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate Down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate Up" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate Right" })

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

-- flash
vim.keymap.set({ "n", "x", "o" }, "<M-s>", function()
  require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "<M-S>", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })

-- treesitter textobjects: move (jump between functions, classes, parameters)
local ts_move = require("nvim-treesitter-textobjects.move")
vim.keymap.set({ "n", "x", "o" }, "]f", function()
  ts_move.goto_next_start("@function.outer")
end, { desc = "Next Function Start" })
vim.keymap.set({ "n", "x", "o" }, "]F", function()
  ts_move.goto_next_end("@function.outer")
end, { desc = "Next Function End" })
vim.keymap.set({ "n", "x", "o" }, "[f", function()
  ts_move.goto_previous_start("@function.outer")
end, { desc = "Prev Function Start" })
vim.keymap.set({ "n", "x", "o" }, "[F", function()
  ts_move.goto_previous_end("@function.outer")
end, { desc = "Prev Function End" })
vim.keymap.set({ "n", "x", "o" }, "]c", function()
  ts_move.goto_next_start("@class.outer")
end, { desc = "Next Class Start" })
vim.keymap.set({ "n", "x", "o" }, "]C", function()
  ts_move.goto_next_end("@class.outer")
end, { desc = "Next Class End" })
vim.keymap.set({ "n", "x", "o" }, "[c", function()
  ts_move.goto_previous_start("@class.outer")
end, { desc = "Prev Class Start" })
vim.keymap.set({ "n", "x", "o" }, "[C", function()
  ts_move.goto_previous_end("@class.outer")
end, { desc = "Prev Class End" })
vim.keymap.set({ "n", "x", "o" }, "]a", function()
  ts_move.goto_next_start("@parameter.inner")
end, { desc = "Next Parameter Start" })
vim.keymap.set({ "n", "x", "o" }, "]A", function()
  ts_move.goto_next_end("@parameter.inner")
end, { desc = "Next Parameter End" })
vim.keymap.set({ "n", "x", "o" }, "[a", function()
  ts_move.goto_previous_start("@parameter.inner")
end, { desc = "Prev Parameter Start" })
vim.keymap.set({ "n", "x", "o" }, "[A", function()
  ts_move.goto_previous_end("@parameter.inner")
end, { desc = "Prev Parameter End" })

-- new file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", { desc = "Oil" })

vim.keymap.set("n", "<leader>up", function()
  vim.pack.update()
end, { desc = "Update Plugins" })

vim.keymap.set("n", "<leader>uw", function()
  vim.o.wrap = not vim.o.wrap
  vim.notify("Line wrap: " .. (vim.o.wrap and "on" or "off"))
end, { desc = "Toggle Line Wrap" })

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
--- LSP (FzfLua overrides)
----------------
vim.keymap.set(
  "n",
  "grr",
  "<cmd>FzfLua lsp_references jump1=true ignore_current_line=true<cr>",
  { desc = "References", nowait = true }
)
vim.keymap.set(
  "n",
  "gri",
  "<cmd>FzfLua lsp_implementations jump1=true<cr>",
  { desc = "Implementations", nowait = true }
)
vim.keymap.set("n", "grt", "<cmd>FzfLua lsp_typedefs jump1=true<cr>", { desc = "Type Definitions", nowait = true })
vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions jump1=true<cr>", { desc = "Definitions", nowait = true })
vim.keymap.set("n", "gD", "<cmd>FzfLua lsp_declarations jump1=true<cr>", { desc = "Declarations", nowait = true })

----------------
--- FZF
----------------
vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Switch Buffer" })
-- Grep & general
vim.keymap.set("n", "<leader>/", function()
  require("fzf-lua").live_grep({ cwd = require("utils").root() })
end, { desc = "Grep (Root Dir)" })
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
vim.keymap.set("n", "<leader>sg", function()
  require("fzf-lua").live_grep({ cwd = require("utils").root() })
end, { desc = "Grep (Root Dir)" })
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
vim.keymap.set("n", "<leader>sn", function()
  local notifs = MiniNotify.get_all()
  table.sort(notifs, function(a, b)
    return a.ts_update > b.ts_update
  end)
  local lines = {}
  for _, notif in ipairs(notifs) do
    local timestamp = os.date("%H:%M:%S", notif.ts_update)
    local msg = (notif.msg or ""):gsub("\n", " │ ")
    table.insert(lines, string.format("%s │ %-5s │ %s", timestamp, notif.level, msg))
  end
  require("fzf-lua").fzf_exec(lines, {
    prompt = "> ",
    winopts = { title = " Notifications " },
  })
end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>sR", "<cmd>FzfLua resume<cr>", { desc = "Resume" })
vim.keymap.set("n", "<leader>sq", "<cmd>FzfLua quickfix<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>sw", function()
  require("fzf-lua").grep_cword({ cwd = require("utils").root() })
end, { desc = "Word (Root Dir)" })
vim.keymap.set("n", "<leader>sW", function()
  require("fzf-lua").grep_cword({ cwd = vim.uv.cwd() })
end, { desc = "Word (cwd)" })
vim.keymap.set("x", "<leader>sw", function()
  require("fzf-lua").grep_visual({ cwd = require("utils").root() })
end, { desc = "Selection (Root Dir)" })
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
vim.keymap.set("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
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
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
  "n",
  "<leader>xX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = " Buffer Diagnostics (Trouble)" }
)

----------------
--- Formatting
----------------
vim.keymap.set("n", "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown Preview" })
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
if vim.lsp.codelens then
  -- Snacks.toggle.codelens():map("<leader>uc")
  Snacks.toggle
    .new({
      name = "Codelens",
      get = function()
        return vim.lsp.codelens.is_enabled()
      end,
      set = function(state)
        vim.lsp.codelens.enable(state)
      end,
    })
    :map("<leader>uc")
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
vim.keymap.set("n", "<leader>un", function()
  MiniNotify.clear()
end, { desc = "Dismiss All Notifications" })
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
vim.keymap.set("n", "<leader>cl", function()
  Snacks.picker.lsp_config()
end, { desc = "Lsp Info" })
vim.keymap.set("n", "<leader>ci", function()
  Snacks.picker.lsp_incoming_calls()
end, { desc = "C[a]lls Incoming" })
vim.keymap.set("n", "<leader>co", function()
  Snacks.picker.lsp_outgoing_calls()
end, { desc = "C[a]lls Outgoing" })

----------------
--- DAP
----------------
-- Function keys
vim.keymap.set("n", "<F2>", function()
  require("dap").terminate()
end, { desc = "Terminate" })
vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Start/Continue" })
vim.keymap.set("n", "<F7>", function()
  require("dap").step_into()
end, { desc = "Step Into" })
vim.keymap.set("n", "<S-F7>", function()
  require("dap").step_out()
end, { desc = "Step Out" })
vim.keymap.set("n", "<F8>", function()
  require("dap").step_over()
end, { desc = "Step Over" })
vim.keymap.set("n", "<F9>", function()
  require("dap").run_to_cursor()
end, { desc = "Run To Cursor" })

-- <leader>d* suite
vim.keymap.set("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Breakpoint Condition" })
vim.keymap.set("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Run/Continue" })
vim.keymap.set("n", "<leader>dC", function()
  require("dap").run_to_cursor()
end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dg", function()
  require("dap").goto_()
end, { desc = "Go to Line (No Execute)" })
vim.keymap.set("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dj", function()
  require("dap").down()
end, { desc = "Down" })
vim.keymap.set("n", "<leader>dk", function()
  require("dap").up()
end, { desc = "Up" })
vim.keymap.set("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Run Last" })
vim.keymap.set("n", "<leader>do", function()
  require("dap").step_out()
end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dO", function()
  require("dap").step_over()
end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dP", function()
  require("dap").pause()
end, { desc = "Pause" })
vim.keymap.set("n", "<leader>dr", function()
  require("dap").repl.toggle()
end, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>ds", function()
  require("dap").session()
end, { desc = "Session" })
vim.keymap.set("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "Terminate" })
vim.keymap.set("n", "<leader>dw", function()
  require("dap.ui.widgets").hover()
end, { desc = "Widgets" })
vim.keymap.set("n", "<leader>du", function()
  require("dapui").toggle({})
end, { desc = "Toggle DAP UI" })
vim.keymap.set({ "n", "x" }, "<leader>de", function()
  require("dapui").eval()
end, { desc = "Eval" })

----------------
--- Yanky
----------------
vim.keymap.set({ "n", "x" }, "<leader>p", function()
  vim.cmd("YankyRingHistory")
end, { desc = "Yank History" })
vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "Yank Text" })
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Put After" })
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Put Before" })
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Put After Selection" })
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Put Before Selection" })
vim.keymap.set("n", "[y", "<Plug>(YankyCycleForward)", { desc = "Cycle Forward Through Yank History" })
vim.keymap.set("n", "]y", "<Plug>(YankyCycleBackward)", { desc = "Cycle Backward Through Yank History" })
