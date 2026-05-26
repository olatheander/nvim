-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Enable inlay hints when supported",
  group = vim.api.nvim_create_augroup("lsp-inlay-hints", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Open neo-tree on startup",
  group = vim.api.nvim_create_augroup("neotree-open", { clear = true }),
  callback = function()
    require("neo-tree.command").execute({ action = "show", dir = vim.uv.cwd() })
    -- vim.cmd("wincmd p") -- move focus to buffer instead of Neotree.
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  desc = "Run linters on write",
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = function()
    require("lint").try_lint()
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
  desc = "Check for file changes when focus is gained or cursor is idle",
  group = vim.api.nvim_create_augroup("checktime", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Enable LSP folding when supported",
  group = vim.api.nvim_create_augroup("lsp-folding", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = "expr"
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
      vim.wo[win][0].foldlevel = 99
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable Treesitter folding",
  group = vim.api.nvim_create_augroup("treesitter-folding", { clear = true }),
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local lang = vim.bo[buf].filetype
    local has_parser = pcall(vim.treesitter.get_parser, buf, lang)
    if has_parser then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldlevel = 99
    end
  end,
})
