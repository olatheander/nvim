-- [[ Utility functions ]]

local M = {}

--- Detect project root for the current buffer.
--- Searches upward from the buffer's file for common project root markers.
--- Falls back to cwd if no marker is found.
---@param buf? integer buffer number (defaults to current buffer)
---@return string root directory path
function M.root(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local root = vim.fs.root(buf, {
    -- Version control
    ".git",
    -- Java / JVM
    "gradlew",
    "mvnw",
    "pom.xml",
    "build.gradle",
    "build.gradle.kts",
    -- JavaScript / TypeScript
    "package.json",
    -- Python
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    -- Rust
    "Cargo.toml",
    -- Go
    "go.mod",
    -- Lua / Neovim
    ".luarc.json",
  })
  return root or vim.uv.cwd()
end

return M
