-- Globals must be set before the plugin loads (vim-slime reads them at load time)
vim.g.slime_target = 'neovim'
vim.g.slime_no_mappings = 1
vim.g.slime_dont_ask_default = 1
vim.g.slime_neovim_ignore_unlisted = 1

vim.pack.add({ 'https://github.com/jpalardy/vim-slime' })
