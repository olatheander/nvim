-- [[ DAP Configuration ]]

require("dapui").setup()
require("nvim-dap-virtual-text").setup({})

-- Python: use Mason's debugpy install if available
local debugpy_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
if vim.fn.executable(debugpy_python) == 1 then
  require("dap-python").setup(debugpy_python)
end

-- JavaScript/TypeScript: use Mason's js-debug-adapter
local dap = require("dap")

for _, adapterType in ipairs({ "node", "chrome", "msedge" }) do
  local pwaType = "pwa-" .. adapterType

  if not dap.adapters[pwaType] then
    dap.adapters[pwaType] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
      },
    }
  end

  -- Define adapters without the "pwa-" prefix for VSCode compatibility
  if not dap.adapters[adapterType] then
    dap.adapters[adapterType] = function(cb, config)
      local nativeAdapter = dap.adapters[pwaType]

      config.type = pwaType

      if type(nativeAdapter) == "function" then
        nativeAdapter(cb, config)
      else
        cb(nativeAdapter)
      end
    end
  end
end

-- Sign definitions for breakpoints and stopped lines
local dap_signs = {
  Breakpoint = { text = " ", texthl = "DiagnosticError" },
  BreakpointCondition = { text = " ", texthl = "DiagnosticWarn" },
  BreakpointRejected = { text = " ", texthl = "DiagnosticHint" },
  LogPoint = { text = ".>", texthl = "DiagnosticInfo" },
  Stopped = { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "DiagnosticWarn" },
}
for name, sign in pairs(dap_signs) do
  vim.fn.sign_define("Dap" .. name, sign)
end

-- .vscode/launch.json files are auto-loaded by nvim-dap's built-in dap.launch.json provider.
