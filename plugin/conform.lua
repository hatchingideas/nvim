vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })
vim.loader.reset()

require('conform').setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    python = { 'ruff_format' },  -- pip install ruff
    r      = { 'styler' },       -- install.packages("styler") in R
    lua    = { 'stylua' },       -- cargo install stylua
  },
})
