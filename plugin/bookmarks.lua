vim.pack.add({ 'https://github.com/chentoast/marks.nvim' })
vim.loader.reset()

require('marks').setup({
  default_mappings = false,
  signs = true,
  sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
  bookmark_0 = { sign = '⚑', virt_text = '' },
})

-- m1-m9: set bookmark, <leader>1-9: jump to bookmark
local slots = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i' }
for i, letter in ipairs(slots) do
  vim.keymap.set('n', 'm' .. i, 'm' .. letter,  { desc = 'Set bookmark ' .. i })
  vim.keymap.set('n', '<leader>' .. i, "'" .. letter, { desc = 'Jump to bookmark ' .. i })
end

-- <leader>m: browse all bookmarks via Telescope (telescope is loaded later alphabetically, but
-- the keymap is a lazy vim command so telescope doesn't need to be loaded at definition time)
vim.keymap.set('n', '<leader>m', '<cmd>Telescope marks<cr>', { desc = 'Browse bookmarks' })

-- dm1-dm9: delete a numbered bookmark
for i, letter in ipairs(slots) do
  vim.keymap.set('n', 'dm' .. i, function()
    vim.cmd('delmark ' .. letter)
    vim.notify('Bookmark ' .. i .. ' deleted', vim.log.levels.INFO)
  end, { desc = 'Delete bookmark ' .. i })
end
