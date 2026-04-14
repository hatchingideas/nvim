vim.pack.add({ 'https://github.com/folke/which-key.nvim' })
vim.loader.reset()

local wk = require('which-key')
wk.setup()
wk.add({
  { '<leader>f', group = 'find' },
  { '<leader>g', group = 'git' },
  { '<leader>d', group = 'debug' },
  { '<leader>r', group = 'R' },
  { '<leader>t', group = 'terminal' },
  { '<leader>x', group = 'diagnostics' },
  { '<leader>c', group = 'claude' },
})
