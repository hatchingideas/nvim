-- nvim-treesitter is listed here too since quarto.lua (q) is sourced before
-- treesitter.lua (t); vim.pack.add() is idempotent for already-loaded plugins
vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/jmbuhr/otter.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/quarto-dev/quarto-nvim',
})
vim.loader.reset()

require('render-markdown').setup({
  file_types = { 'markdown', 'quarto' },
})

require('quarto').setup({
  lspFeatures = {
    languages = { 'python', 'r' },
    chunks = 'all',
    diagnostics = {
      enabled = true,
      triggers = { 'BufWritePost' },
    },
    completion = {
      enabled = true,
    },
  },
  codeRunner = {
    enabled = true,
    default_method = 'slime',
  },
})
