vim.pack.add({
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/mfussenegger/nvim-dap-python',
  'https://github.com/rcarriga/nvim-dap-ui',
})
vim.loader.reset()

require('dap-python').setup('python')

local dap   = require('dap')
local dapui = require('dapui')
dapui.setup()

-- Auto-open/close DAP UI with debug session lifecycle
dap.listeners.after.event_initialized['dapui_config']  = function() dapui.open()  end
dap.listeners.before.event_terminated['dapui_config']  = function() dapui.close() end
dap.listeners.before.event_exited['dapui_config']      = function() dapui.close() end
