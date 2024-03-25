# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Issues and gotchas

### clangd and copilot encoding conflict

```
warning: multiple different client offset_encodings detected for buffer, this is not supported yet`
```

The file `~/.local/share/nvim/lazy/nvim-lspconfig/lua/lspconfig/server_configurations/clangd.lua` defines multiple offset_encodings

```
local default_capabilities = {
  textDocument = {
    completion = {
      editsNearCursor = true,
    },
  },
  offsetEncoding = { 'utf-8', 'utf-16' },
}
```

which cause the warning. To fix it, remove the `utf-8` encoding (copilot must have utf-16 encoding), as suggested [here](https://github.com/neovim/nvim-lspconfig/issues/2184#issuecomment-1511154286).

The LazyVim [Fix clangd offset encoding](https://www.lazyvim.org/configuration/recipes#fix-clangd-offset-encoding) seems not to fix it (which is also included in the default LazyExtras [config](https://github.com/LazyVim/LazyVim/blob/864c58cae6df28c602ecb4c94bc12a46206760aa/lua/lazyvim/plugins/extras/lang/clangd.lua#L68)).
