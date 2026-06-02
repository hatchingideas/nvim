-- Load colorscheme first (00- prefix ensures alphabetical priority)
vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
})
vim.loader.reset()
require('catppuccin').setup({
  flavour = 'mocha',
  integrations = { bufferline = true },
})
vim.cmd.colorscheme('catppuccin')
