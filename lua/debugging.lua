-- [[ DAP Configuration ]]

require("dapui").setup()
require("nvim-dap-virtual-text").setup({})

-- Python: use Mason's debugpy install if available
local debugpy_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
if vim.fn.executable(debugpy_python) == 1 then
  require("dap-python").setup(debugpy_python)
end

-- Sign definitions for breakpoints and stopped lines
local dap_signs = {
  Breakpoint = { text = "", texthl = "DiagnosticError" },
  BreakpointCondition = { text = "", texthl = "DiagnosticWarn" },
  BreakpointRejected = { text = "", texthl = "DiagnosticHint" },
  LogPoint = { text = "", texthl = "DiagnosticInfo" },
  Stopped = { text = "", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "DiagnosticWarn" },
}
for name, sign in pairs(dap_signs) do
  vim.fn.sign_define("Dap" .. name, sign)
end

-- .vscode/launch.json files are auto-loaded by nvim-dap's built-in dap.launch.json provider.
