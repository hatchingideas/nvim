-- plenary is also a dependency of telescope; loading it here ensures todo-comments
-- can find it even though telescope.lua (t) is sourced after editing.lua (e)
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/numToStr/Comment.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/folke/flash.nvim',
  'https://github.com/folke/todo-comments.nvim',
})
vim.loader.reset()

require('nvim-autopairs').setup()
require('Comment').setup()
require('ibl').setup()
require('nvim-surround').setup()
require('flash').setup()
require('todo-comments').setup()

-- flash.nvim motion keys
vim.keymap.set({ 'n', 'x', 'o' }, 's',     function() require('flash').jump() end,       { desc = 'Flash jump' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S',     function() require('flash').treesitter() end,  { desc = 'Flash treesitter' })
vim.keymap.set('o',               'r',     function() require('flash').remote() end,      { desc = 'Flash remote' })
vim.keymap.set('c',               '<C-s>', function() require('flash').toggle() end,      { desc = 'Flash search toggle' })
