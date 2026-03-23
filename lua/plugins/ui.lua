return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "mocha" })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Status line
  { "nvim-lualine/lualine.nvim", config = true },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- Fuzzy finder (live_grep requires: sudo apt install ripgrep)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Required by claudecode.nvim
  { "folke/snacks.nvim" },

  -- Shows available keymaps in a popup after pressing <leader>
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      wk.setup()
      -- Label leader key groups for cleaner popup display
      wk.add({
        { "<leader>f",  group = "find" },
        { "<leader>g",  group = "git" },
        { "<leader>d",  group = "debug" },
        { "<leader>r",  group = "R" },
        { "<leader>t",  group = "terminal" },
        { "<leader>x",  group = "diagnostics" },
        { "<leader>c",  group = "claude" },
      })
    end,
  },

  -- Diagnostics, errors, warnings in a panel (<leader>xx)
  {
    "folke/trouble.nvim",
    config = true,
  },
}
