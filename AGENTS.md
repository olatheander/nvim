# AGENTS.md — Neovim 0.12 Configuration

This is a personal Neovim 0.12 configuration. It uses **native Neovim 0.12 APIs**
exclusively — no LazyVim framework, no deprecated patterns.

## Environment

- **Neovim version**: 0.12.0 (binary at `/home/olathe/tmp/neovim/bin/nvim`)
- **Config location**: `~/.config/nvim-12` (symlink to this repo)
- **NVIM_APPNAME**: Always use `NVIM_APPNAME=nvim-12` when launching or testing
- **Package manager**: `vim.pack.add()` (Neovim 0.12 built-in), NOT lazy.nvim
- **Lock file**: `nvim-pack-lock.json` — commit when plugin versions change

## Build / Lint / Test Commands

There are no automated tests, CI, or Makefile. Validation is manual:

```bash
# Format all Lua files (StyLua must be installed)
stylua lua/ init.lua ftplugin/

# Check a single file
stylua --check lua/keymaps.lua

# Lint with lua_ls diagnostics (runs inside Neovim via LSP)
# No standalone lint command — rely on lua_ls in-editor diagnostics

# Verify config loads without errors
NVIM_APPNAME=nvim-12 /home/olathe/tmp/neovim/bin/nvim --headless "+q"

# Check for Lua syntax errors in a single file
luac -p lua/plugins.lua
```

Always run `stylua` before committing. The formatter config is in `.stylua.toml`.

## Architecture & Load Order

`init.lua` sets leader keys and globals, then loads modules in this exact order:

1. `require("options")` — Vim options (`vim.o.*`, `vim.opt.*`)
2. `require("plugins")` — `vim.pack.add()` declarations + all plugin `.setup()` calls
3. `require("keymaps")` — All keymaps (basic, fzf-lua, neotree, snacks, toggles)
4. `require("autocmds")` — Autocommands (yank highlight, LSP attach hooks)
5. `require("lsp")` — LSP server configs via `vim.lsp.config()` + `vim.lsp.enable()`

After module loading, `init.lua` configures diagnostics and sets the colorscheme.

**Critical ordering constraint**: `require("snacks").setup({})` is called at the end of
`plugins.lua` so that the `Snacks` global is available when `keymaps.lua` runs.

### File layout

```
init.lua              Entry point — leader, load order, diagnostics, colorscheme
lua/
  options.lua         Vim options
  plugins.lua         vim.pack.add() + plugin setup() calls
  keymaps.lua         All keymaps organized by section
  autocmds.lua        Autocommands with named augroups
  lsp.lua             LSP server configs and vim.lsp.enable()
ftplugin/
  java.lua            nvim-jdtls config via start_or_attach()
.stylua.toml          StyLua formatter config
.luarc.json           lua_ls diagnostics globals
nvim-pack-lock.json   Plugin version lock file
```

## Code Style

### Formatting (enforced by StyLua)

- **Indent**: 2 spaces, no tabs
- **Line width**: 120 columns max
- **Quotes**: Double quotes (`"string"`) — `AutoPreferDouble`
- **Call parentheses**: Always required — `require("foo")` not `require "foo"`
- **Line endings**: Unix (LF)
- **Collapse simple statements**: Never (always use full block form)

### Naming Conventions

- **Local variables / functions**: `snake_case` — `workspace_dir`, `project_name`
- **Augroup names**: `kebab-case` — `"lsp-inlay-hints"`, `"highlight-yank"`
- **Keymap descriptions**: Title Case — `"Find Files (Root Dir)"`, `"Git Blame Line"`
- **Leader key groups**: `f`=find, `s`=search, `g`=git, `b`=buffers, `c`=code,
  `u`=UI toggles, `w`=windows, `x`=quickfix/diagnostics, `t`=test

### Imports / Requires

- Config modules loaded via bare `require("module")` in `init.lua` — no pcall wrapping
- Plugin APIs called inline: `require("fzf-lua").files()`, `require("conform").format()`
- Only assign to a local when the module is referenced multiple times in the same file:
  ```lua
  local jdtls = require("jdtls")  -- used 10+ times in ftplugin/java.lua
  ```
- Never use `pcall(require, ...)` — assume plugins are installed

### Comments

- Section banners in keymaps:
  ```lua
  ----------------
  --- Section Name
  ----------------
  ```
- Header comments in `init.lua` use `-- [[ Section Name ]]`
- Inline comments: `-- explanation` (space after `--`)
- Use `NOTE:` prefix for important callouts: `--  NOTE: Must happen before plugins`
- Help references: `--  See ':help topic'`
- StyLua directives when needed: `-- stylua: ignore start` / `-- stylua: ignore end`

### Keymaps

- Always use `vim.keymap.set(mode, lhs, rhs, opts)` — never `vim.api.nvim_set_keymap`
- Always include `desc` in the options table
- FzfLua keymaps: use `require("fzf-lua").method()` directly, NOT `LazyVim.pick()`
- Format keymaps: use `require("conform").format()` directly, NOT `LazyVim.format()`
- Buffer-local keymaps (e.g., in `on_attach`): use a local helper:
  ```lua
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
  end
  ```

### Autocommands

- Always use `vim.api.nvim_create_autocmd()` with an inline augroup
- Each autocmd gets its own `vim.api.nvim_create_augroup("name", { clear = true })`
- Always include `desc` field
- Check capabilities before acting: `client:supports_method("textDocument/...")`

### LSP Configuration

- **Use Neovim 0.12 native API only**:
  ```lua
  vim.lsp.config("server_name", { settings = { ... } })
  vim.lsp.enable({ "server1", "server2" })
  ```
- **Do NOT use**: `require("lspconfig").server.setup()` — this is deprecated in 0.12
- Servers with no custom settings still get declared: `vim.lsp.config("pyright", {})`
- All servers enabled in a single `vim.lsp.enable()` call at the end of `lsp.lua`
- **jdtls exception**: Managed by nvim-jdtls via `ftplugin/java.lua` using
  `start_or_attach()` — do NOT add `"jdtls"` to `vim.lsp.enable()`

### Plugin Declarations

- Use `vim.pack.add()` with GitHub HTTPS URLs:
  ```lua
  vim.pack.add({
    "https://github.com/user/plugin",
    { src = "https://github.com/user/plugin2", build = ":Command" },
  })
  ```
- Plugin `.setup()` calls go in `plugins.lua`, after the `vim.pack.add()` block
- Plugin keymaps go in `keymaps.lua`, not alongside setup (exception: `on_attach` callbacks)

### Toggles

- UI toggles use `Snacks.toggle.new({ name, get, set }):map("<leader>u_")`
- Format toggle uses `vim.g.disable_autoformat` (global) and `vim.b.disable_autoformat` (buffer)

### Error Handling

- Minimal — this is a personal config, not a library
- Use conditional checks for optional features:
  ```lua
  if vim.fn.executable("lazygit") == 1 then ... end
  if vim.lsp.inlay_hint then ... end
  ```
- Check LSP capabilities before enabling features: `client:supports_method(...)`

## Default Neovim 0.12 Mappings (do not duplicate)

These are mapped by Neovim 0.12 itself on `LspAttach` — do not re-map them:

- `K` — `vim.lsp.buf.hover()`
- `<C-s>` (insert mode) — `vim.lsp.buf.signature_help()`

## Commit Messages

- Imperative mood, capitalized, no trailing period
- Describe what changed and optionally why
- List multiple changes with commas: `"Add X, update Y, and fix Z"`
- No conventional-commit prefixes (`feat:`, `fix:`, etc.)
- No issue/PR references
