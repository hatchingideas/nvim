return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",  -- fall back to LSP formatting if no formatter found
      },
      formatters_by_ft = {
        python = { "ruff_format" },  -- pip install ruff
        r      = { "styler" },       -- install.packages("styler") in R
        lua    = { "stylua" },       -- cargo install stylua  (optional)
      },
    },
  },
}
