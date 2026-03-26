-- ============================================
-- Leader key (must be set before lazy.setup)
-- ============================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================
-- Bootstrap lazy.nvim
-- ============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================
-- Shell: WSL zsh on Windows, zsh on Linux
-- ============================================
local shell_cmd = vim.fn.has("win32") == 1 and "wsl zsh" or "zsh"

-- ============================================
-- General settings
-- ============================================
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 250

-- Force buffer reload on focus (important for Claude Code file changes)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime"
})

-- ============================================
-- Plugins
-- ============================================
require("lazy").setup("plugins", {
  git = { timeout = 600 },
})

-- ============================================
-- Keymaps
-- ============================================
vim.keymap.set("n", "<leader>e",  "<cmd>NvimTreeToggle<CR>",      { silent = true, desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { silent = true, desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",  { silent = true, desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>",    { silent = true, desc = "Find buffers" })
vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<CR>",           { silent = true, desc = "Toggle Claude Code" })
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>",         { silent = true, desc = "Open diff view" })
vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<CR>",        { silent = true, desc = "Close diff view" })
vim.keymap.set("n", "<leader>tw", "<cmd>belowright split | terminal " .. shell_cmd .. "<CR>", { silent = true, desc = "Open terminal" })
vim.keymap.set("n", "<leader>ty", "<cmd>belowright split | terminal python %<CR>",   { silent = true, desc = "Run current file in Python" })

-- Window navigation: handled by vim-tmux-navigator plugin (lua/plugins/vim-tmux-navigator.lua)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>",        { silent = true, desc = "Exit terminal mode" })

-- DAP debugger keymaps
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { silent = true, desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end,          { silent = true, desc = "DAP continue" })
vim.keymap.set("n", "<leader>ds", function() require("dap").step_over() end,         { silent = true, desc = "DAP step over" })
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end,         { silent = true, desc = "DAP step into" })
vim.keymap.set("n", "<leader>do", function() require("dap").step_out() end,          { silent = true, desc = "DAP step out" })
vim.keymap.set("n", "<leader>du", function() require("dapui").toggle() end,          { silent = true, desc = "Toggle DAP UI" })

-- Send code to REPL
vim.keymap.set("v", "<C-x>", "<Plug>SlimeRegionSend", { desc = "Send selection to REPL" })
vim.keymap.set("n", "<C-x>", "<Plug>SlimeLineSend",   { desc = "Send line to REPL" })

-- R keymaps (only active in .R files)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "r",
  callback = function()
    vim.keymap.set("n", "<leader>rs", "<cmd>RStart<CR>",          { buffer = true, silent = true, desc = "R start" })
    vim.keymap.set("n", "<leader>rq", "<cmd>RStop<CR>",           { buffer = true, silent = true, desc = "R stop" })
    vim.keymap.set("n", "<leader>rl", "<cmd>RDSendLine<CR>",      { buffer = true, silent = true, desc = "R send line" })
    vim.keymap.set("n", "<leader>rf", "<cmd>RDSendFile<CR>",      { buffer = true, silent = true, desc = "R send file" })
    vim.keymap.set("v", "<leader>rs", "<cmd>RDSendSelection<CR>", { buffer = true, silent = true, desc = "R send selection" })
    vim.keymap.set("n", "<leader>rb", "<cmd>RDSendMBlock<CR>",    { buffer = true, silent = true, desc = "R send block" })
    vim.keymap.set("n", "<leader>rh", "<cmd>RHelp<CR>",           { buffer = true, silent = true, desc = "R help" })
    vim.keymap.set("n", "<leader>ro", "<cmd>RObjectPrint<CR>",    { buffer = true, silent = true, desc = "R print object" })
    vim.keymap.set("n", "<leader>rv", "<cmd>RViewDF<CR>",         { buffer = true, silent = true, desc = "R view dataframe" })
  end,
})

-- ============================================
-- Coding layout (call with :Coding)
-- ============================================
vim.api.nvim_create_user_command("Coding", function()
  -- Reset to a single window so layout is predictable
  vim.cmd("only")

  -- File tree on the left
  vim.cmd("NvimTreeOpen")
  vim.cmd("vertical resize 30")

  -- Claude Code on the right
  vim.cmd("ClaudeCode")

  -- Move to the center editor pane and split a terminal below it
  vim.cmd("wincmd h")
  vim.cmd("split")
  vim.cmd("wincmd j")
  vim.cmd("terminal " .. shell_cmd)
  vim.cmd("resize 12")

  -- Wire slime to this terminal (schedule to ensure job_id is ready)
  vim.schedule(function()
    local jobid = vim.b.terminal_job_id
    if jobid then
      vim.g.slime_default_config = { jobid = jobid }
      vim.g.slime_dont_ask_default = 1
    end

    -- Return cursor to the main editor pane
    vim.cmd("wincmd k")
    if jobid then
      vim.b.slime_config = { jobid = jobid }
    end
  end)
end, { desc = "Open coding layout (tree + editor + terminal + Claude)" })

vim.api.nvim_create_user_command("CodingClose", function()
  -- Close NvimTree if open
  pcall(vim.cmd, "NvimTreeClose")
  -- Close Claude Code if open
  pcall(vim.cmd, "ClaudeCodeClose")
  -- Close all terminal buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end
  end
  -- Reset to single window
  vim.cmd("only")
end, { desc = "Close coding layout" })
