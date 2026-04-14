-- PackChanged hook must be registered before vim.pack.add() so it fires
-- during the initial install as well as future updates
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    -- Install desired parsers (! = force reinstall if already present)
    vim.cmd('TSInstall! python r lua markdown vim vimdoc')
  end
end })

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })
vim.loader.reset()

-- New nvim-treesitter API: .configs module is gone; .setup() only accepts install_dir.
-- Highlighting is enabled per-buffer via vim.treesitter.start() (built into Neovim 0.10+).
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})
