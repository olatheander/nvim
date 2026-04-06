-- ftplugin/java.lua
-- nvim-jdtls configuration; runs on every Java FileType event.
-- Uses start_or_attach which reuses existing clients for the same root_dir.

local jdtls = require("jdtls")
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"

-- Collect DAP bundles (java-debug-adapter + java-test)
local bundles = {}
vim.list_extend(
  bundles,
  vim.fn.glob(
    mason_packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
    false,
    true
  )
)
for _, jar in ipairs(vim.fn.glob(mason_packages .. "/java-test/extension/server/*.jar", false, true)) do
  local fname = vim.fn.fnamemodify(jar, ":t")
  -- These jars must be excluded per nvim-jdtls docs
  if fname ~= "com.microsoft.java.test.runner-jar-with-dependencies.jar" and fname ~= "jacocoagent.jar" then
    table.insert(bundles, jar)
  end
end

-- Per-project workspace data directory
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"

local config = {
  cmd = { "jdtls", "-data", workspace_dir },
  root_dir = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", "build.gradle", ".git" }),
  settings = {
    java = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        formatParameters = { enabled = true },
      },
    },
  },
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = require("jdtls.capabilities"),
  },
  on_attach = function(_, buf)
    -- Setup DAP integration if java-debug-adapter is available
    if #bundles > 0 then
      jdtls.setup_dap()
    end

    -- Java-specific keymaps
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
    end

    map("n", "<leader>co", jdtls.organize_imports, "Organize Imports")
    map("n", "<leader>cxv", jdtls.extract_variable_all, "Extract Variable")
    map("x", "<leader>cxv", function()
      jdtls.extract_variable_all(true)
    end, "Extract Variable")
    map("n", "<leader>cxc", jdtls.extract_constant, "Extract Constant")
    map("x", "<leader>cxc", function()
      jdtls.extract_constant(true)
    end, "Extract Constant")
    map("x", "<leader>cxm", function()
      jdtls.extract_method(true)
    end, "Extract Method")
    map("n", "<leader>cgs", jdtls.super_implementation, "Goto Super Implementation")

    -- Test keymaps (require java-debug-adapter + java-test)
    if #bundles > 0 then
      map("n", "<leader>tt", jdtls.test_class, "Run All Tests")
      map("n", "<leader>tr", jdtls.test_nearest_method, "Run Nearest Test")
      map("n", "<leader>tT", jdtls.pick_test, "Pick Test")
    end
  end,
}

jdtls.start_or_attach(config)
