vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-tree.lua', name = 'nvim-tree' },
})
vim.loader.reset()
require('nvim-tree').setup({
  filesystem_watchers = { enable = true },
  update_focused_file = { enable = true },
})
