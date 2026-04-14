-- snacks.nvim is required by claudecode.nvim; must be loaded first
vim.pack.add({
  'https://github.com/folke/snacks.nvim',
  'https://github.com/coder/claudecode.nvim',
})
vim.loader.reset()
require('claudecode').setup()
