vim.pack.add({
  'https://github.com/rafamadriz/friendly-snippets',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('*') },
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',
})
vim.loader.reset()

require('blink.cmp').setup({
  keymap = { preset = 'default' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
})

require('mason').setup()
require('mason-lspconfig').setup({
  -- Auto-install these servers if not already present (:Mason to manage manually)
  ensure_installed = { 'pyright' },
  -- r_language_server: install manually in R with install.packages("languageserver")
})

-- Python LSP (pip install pyright  or  npm i -g pyright)
vim.lsp.config('pyright', {})
vim.lsp.enable('pyright')

-- R LSP (install.packages("languageserver") in R)
vim.lsp.config('r_language_server', {})
vim.lsp.enable('r_language_server')

-- Lua LSP with Neovim runtime awareness
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        library = { vim.env.VIMRUNTIME },
        checkThirdParty = false,
      },
    },
  },
})
vim.lsp.enable('lua_ls')
