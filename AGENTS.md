# AGENTS.md — Neovim Configuration

This is a personal Neovim configuration built on **LazyVim** (the distribution by folke).
All code is Lua. There is no Vim script. The plugin manager is **lazy.nvim**.

## Project Structure

```
init.lua                      # Entry point — requires config.lazy
lua/config/
  lazy.lua                    # lazy.nvim bootstrap + LazyVim setup + extras
  options.lua                 # vim.opt / vim.g settings
  keymaps.lua                 # Custom keymaps (imperative, no return value)
  autocmds.lua                # Custom autocommands (imperative, no return value)
lua/plugins/
  *.lua                       # Plugin specs — one concern per file, each returns a table
after/ftplugin/
  *.lua                       # Filetype-specific overrides (imperative, no return value)
stylua.toml                   # Formatter config
lazy-lock.json                # Plugin version lock file
lazyvim.json                  # LazyVim extras manifest
```

## Build / Lint / Test Commands

This is a Neovim config, not a standalone project. There is no Makefile, CI, or test suite.

### Formatting (StyLua)

```bash
# Format all Lua files
stylua lua/ init.lua after/

# Format a single file
stylua lua/plugins/lsp.lua

# Check formatting without modifying
stylua --check lua/ init.lua after/
```

Configuration is in `stylua.toml`:
- Indent: 2 spaces
- Column width: 120

### Linting

No luacheck or selene config exists. Rely on `lua-language-server` diagnostics
within Neovim itself. No CLI lint step.

### Validation

Open Neovim and check for errors:
```bash
nvim --headless "+Lazy! sync" +qa        # Sync plugins
nvim --headless "+checkhealth" +qa       # Run health checks
```

## Code Style Guidelines

### Formatting

- **Formatter**: StyLua (2-space indent, 120-column width)
- **Quotes**: Always double quotes (`"string"`, never `'string'`)
- **Trailing commas**: Always include in multi-line tables
- **Line breaks**: Let StyLua handle wrapping at 120 columns

### Naming Conventions

| Element             | Convention    | Examples                                    |
|---------------------|---------------|---------------------------------------------|
| Variables           | `snake_case`  | `metals_config`, `java_filetypes`           |
| Functions           | `snake_case`  | `on_attach`, `has_words_before`             |
| Plugin filenames    | `kebab-case`  | `lsp-metals.lua`, `vim-tmux-navigator.lua`  |
| Config filenames    | single word   | `options.lua`, `keymaps.lua`, `lazy.lua`    |
| Augroup names       | `kebab-case`  | `"nvim-metals"`                             |

### Imports / Requires

- Use `require()` with double-quoted absolute paths from the `lua/` root:
  ```lua
  require("config.lazy")
  require("metals").bare_config()
  ```
- No relative requires. No `local M = require(...)` at file top unless needed.
- Defer requires inside functions when used for lazy-loaded plugins:
  ```lua
  function()
    require("dap").continue()
  end
  ```

### Module / File Patterns

**Plugin spec files** (`lua/plugins/*.lua`):
- Always `return { { ... }, { ... } }` — a list of plugin spec tables.
- Even single-plugin files wrap the spec in an outer list.
- Prefer `opts` table over `opts` function over `config` function.
- Use `config = true` when a plugin only needs `setup()` with no arguments.
- Disable inherited keymaps with `{ "<key>", false }` in the `keys` table.

```lua
return {
  {
    "author/plugin-name",
    opts = {
      setting = "value",
    },
  },
}
```

**Config files** (`lua/config/*.lua`):
- Imperative scripts. No return value. Execute side effects directly.

**ftplugin files** (`after/ftplugin/*.lua`):
- Imperative scripts. No return value.

### Keymaps

- Use `vim.keymap.set()` exclusively. Never `vim.api.nvim_set_keymap()`.
- Use `vim.keymap.del()` to remove LazyVim defaults.
- Include a `desc` field for discoverability via which-key:
  ```lua
  vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCycleNext<cr>", {
    noremap = true,
    silent = true,
    desc = "Next Buffer",
  })
  ```
- For simple remaps without special options, the opts table can be omitted:
  ```lua
  vim.keymap.set("n", "<C-d>", "<C-d>zz")
  ```

### Autocommands

- Use `vim.api.nvim_create_autocmd()` with a `callback` function (not a string command).
- Always pass `pattern` as a list, even for single values: `{ "yaml" }`.
- Create augroups with `vim.api.nvim_create_augroup("name", { clear = true })`.

```lua
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "yaml", "yml" },
  callback = function()
    vim.b.autoformat = false
  end,
})
```

### Vim API Preferences

| Task                 | Use                            | Avoid                             |
|----------------------|--------------------------------|-----------------------------------|
| Set keymaps          | `vim.keymap.set()`             | `vim.api.nvim_set_keymap()`       |
| Global variables     | `vim.g.varname = ...`          | `vim.cmd("let g:...")`           |
| Buffer-local vars    | `vim.b.varname = ...`          | `vim.api.nvim_buf_set_var()`      |
| Options              | `vim.opt.name = ...`           | `vim.cmd("set ...")`             |
| Vimscript functions  | `vim.fn.funcname()`            | `vim.cmd("call ...")`            |
| Filesystem           | `vim.fs.find()`                | `vim.fn.glob()` or shell calls   |
| Run vim commands     | `"<cmd>Command<cr>"` in maps  | `vim.cmd()` when avoidable       |

### Error Handling

- Use `pcall(require, "module")` for optional dependencies:
  ```lua
  local ok, mod = pcall(require, "cmp_nvim_lsp")
  if ok then
    config.capabilities = mod.default_capabilities()
  end
  ```
- Generally rely on lazy.nvim's built-in error handling.
- No custom `vim.notify()` error reporting pattern is established.

### Type Annotations

- Not actively used in this config. Do not add LuaLS/EmmyLua annotations
  unless working on a reusable module.

### Comments

- Use `--` line comments. No block comments.
- Prefer rationale comments (explain *why*, not *what*).
- Commented-out code blocks are acceptable as "soft-disabled" configuration
  kept for reference or experimentation.
- Use `-- stylua: ignore` sparingly to override StyLua for intentional one-liners:
  ```lua
  -- stylua: ignore
  if true then return {} end
  ```

### Plugin Configuration Preference Order

1. `opts = { ... }` — declarative table merged with LazyVim defaults (preferred)
2. `opts = function(_, opts) ... end` — when you need access to existing opts
3. `config = function() ... end` — only for complex imperative setup
4. `config = true` — plugin just needs `setup()` with no args

### Lazy-Loading

Use declarative triggers in plugin specs:
- `ft = "python"` — filetype
- `cmd = "IncRename"` — command
- `event = "VeryLazy"` — event
- `keys = { ... }` — keybindings

## Git

- **Committer**: Always use `ola.theander@myola.se` as the committer email when creating commits.
