return {
  { "mfussenegger/nvim-dap" },

  -- Python: uses debugpy (install with: pip install debugpy)
  -- Workflow: <leader>db breakpoint → <leader>dc run file → step with ds/di/do
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      -- Pass venv python path here if needed, e.g. ".venv/bin/python"
      require("dap-python").setup("python3")
    end,
  },

  -- Lua: debugs Neovim config/plugins inside the running Neovim process
  -- Workflow: <leader>db breakpoint → <leader>dl to launch (starts server + attaches)
  {
    "jbyuki/one-small-step-for-vimkind",
    config = function()
      local dap = require("dap")
      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      end
      dap.configurations.lua = {
        {
          type    = "nlua",
          request = "attach",
          name    = "Attach to running Neovim instance",
          host    = "127.0.0.1",
          port    = 8086,
        },
      }
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
