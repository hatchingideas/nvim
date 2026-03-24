vim.g.mapleader = " "        -- Space as leader key
vim.g.maplocalleader = "\\" -- Backslash as local leader (for R.nvim etc.)

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true
vim.opt.updatetime = 300  -- ms before CursorHold fires (also speeds up LSP diagnostics)
-- Requires xclip, xsel, or wl-clipboard on Ubuntu: sudo apt install xclip
vim.opt.clipboard = "unnamedplus"

-- Don't store automatic file-position marks (0-9) in shada across sessions
-- Keeps the marks menu clean; only your own a-z marks are remembered
vim.opt.shada = "!,'100,<50,s10,h"
