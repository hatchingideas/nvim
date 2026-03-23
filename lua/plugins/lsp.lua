return {
  -- Mason: install/manage LSP servers, formatters, linters from inside nvim (:Mason)
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- Auto-install these servers if not present (mason handles the download)
      ensure_installed = { "pyright" },
      -- r_language_server requires R to be installed first; install manually in R:
      --   install.packages("languageserver")
    },
  },

  -- Completion engine
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = { preset = "default" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },

  -- LSP servers
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Python: install with `pip install pyright` or `npm i -g pyright`
      vim.lsp.config("pyright", {})
      vim.lsp.enable("pyright")

      -- R: install with `install.packages("languageserver")` in R
      vim.lsp.config("r_language_server", {})
      vim.lsp.enable("r_language_server")
    end,
  },
}
