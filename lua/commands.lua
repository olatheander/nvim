-- [[ Custom Commands ]]

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd(
    "MasonInstall lua-language-server pyright bash-language-server"
      .. " typescript-language-server gopls clangd yaml-language-server"
      .. " json-lsp marksman eslint-lsp"
      .. " jdtls java-debug-adapter java-test"
      .. " haskell-language-server haskell-debug-adapter"
      .. " stylua prettier prettierd black isort shfmt"
      .. " shellcheck markdownlint mypy ruff"
  )
end, { desc = "Install all Mason tools" })
