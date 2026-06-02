-- Buffer tabs across the top: one clickable "tab" per open buffer.
-- nvim-web-devicons supplies filetype glyphs (needs a Nerd Font in the
-- terminal; without one the labels still show, only the icons may render as
-- boxes). Catppuccin theming is enabled in plugin/00-catppuccin.lua.
vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-web-devicons', name = 'nvim-web-devicons' },
  { src = 'https://github.com/akinsho/bufferline.nvim',     name = 'bufferline' },
})
vim.loader.reset()

require('bufferline').setup({
  options = {
    mode = 'buffers',
    diagnostics = 'nvim_lsp',
    separator_style = 'thin',
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = true,
    -- Keep the tabline clear of the side panes: NvimTree (left) and the
    -- Claude Code / snacks terminal (right, used by the :Coding layout) so
    -- the buffer tabs sit above the editor column.
    offsets = {
      { filetype = 'NvimTree',       text = 'File Explorer', highlight = 'Directory', separator = true },
      { filetype = 'snacks_terminal', text = 'Claude Code',   highlight = 'Directory', separator = true },
    },
  },
})

-- Close the current buffer (tab) but KEEP its window/split open. Plain :bdelete
-- unloads the buffer, leaving its window with nothing to show, so the window
-- closes too. Here we first point every window showing the buffer at the
-- alternate (or previous) listed buffer -- or a fresh empty one if this was the
-- only listed buffer -- and only then delete it. Zero plugins required.
local function close_buffer_keep_window()
  local bufnr = vim.api.nvim_get_current_buf()
  for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
    vim.api.nvim_win_call(win, function()
      local alt = vim.fn.bufnr('#')
      if alt > 0 and alt ~= bufnr and vim.fn.buflisted(alt) == 1 then
        vim.cmd('buffer #')          -- prefer the alternate buffer
      else
        vim.cmd('bprevious')         -- otherwise the previous listed buffer
      end
      if vim.api.nvim_win_get_buf(win) == bufnr then
        vim.cmd('enew')              -- it was the only listed buffer: open a blank
      end
    end)
  end
  if vim.api.nvim_buf_is_valid(bufnr) then
    pcall(vim.cmd, 'bdelete ' .. bufnr)
  end
end

-- Buffer-tab keymaps (commands resolve at press time, so defining them here
-- is fine even though bufferline loads after init.lua).
vim.keymap.set('n', '<Tab>',      '<cmd>BufferLineCycleNext<CR>', { silent = true, desc = 'Next buffer tab' })
vim.keymap.set('n', '<S-Tab>',    '<cmd>BufferLineCyclePrev<CR>', { silent = true, desc = 'Prev buffer tab' })
vim.keymap.set('n', '<leader>bp', '<cmd>BufferLinePick<CR>',      { silent = true, desc = 'Pick buffer tab' })
vim.keymap.set('n', '<leader>bd', close_buffer_keep_window,       { silent = true, desc = 'Close buffer (keep window)' })
vim.keymap.set('n', '<leader>bD', '<cmd>bdelete<CR>',             { silent = true, desc = 'Close buffer + window' })
