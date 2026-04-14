-- plenary is already loaded by editing.lua, but listing it here is idempotent
-- and makes this file self-contained
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
})
vim.loader.reset()
require('telescope').setup()
