-- LazyVim breaks with Mason 2.x, see https://github.com/LazyVim/LazyVim/issues/6039
-- there is a LazyVim PR to fix this: https://github.com/LazyVim/LazyVim/pull/6053

-- return {
--   { "mason-org/mason.nvim", version = "^1.0.0" },
--   { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
-- }

-- PR to fix Mason 2.x support in LazyVim: https://github.com/LazyVim/LazyVim/pull/6053

return { -- https://github.com/LazyVim/LazyVim/pull/6041
  -- "williamboman/mason-lspconfig.nvim",
  -- branch = "v1.x",
}
