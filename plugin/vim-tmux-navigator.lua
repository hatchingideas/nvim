vim.pack.add({ 'https://github.com/christoomey/vim-tmux-navigator' })

-- Plugin registers its own <C-h/j/k/l> mappings; also expose <C-\> for previous pane
vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<cr>')
