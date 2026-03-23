return {
  { "mfussenegger/nvim-dap" },

  {
    "mfussenegger/nvim-dap-python",
    config = function()
      -- On Ubuntu, use python3. For venvs, pass the venv python path instead.
      require("dap-python").setup("python3")
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"]  = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"]  = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end
    end,
  },
}
