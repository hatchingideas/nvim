-- Auto-reload files changed outside Neovim (important for Claude Code)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime",
})

-- R filetype keymaps (buffer-local)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "r",
  callback = function()
    vim.keymap.set("n", "<leader>rs", ":RStart<CR>",          { buffer = true })
    vim.keymap.set("n", "<leader>rq", ":RStop<CR>",           { buffer = true })
    vim.keymap.set("n", "<leader>rl", ":RDSendLine<CR>",      { buffer = true })
    vim.keymap.set("n", "<leader>rf", ":RDSendFile<CR>",      { buffer = true })
    vim.keymap.set("v", "<leader>rs", ":RDSendSelection<CR>", { buffer = true })
    vim.keymap.set("n", "<leader>rb", ":RDSendMBlock<CR>",    { buffer = true })
    vim.keymap.set("n", "<leader>rh", ":RHelp<CR>",           { buffer = true })
    vim.keymap.set("n", "<leader>ro", ":RObjectPrint<CR>",    { buffer = true })
    vim.keymap.set("n", "<leader>rv", ":RViewDF<CR>",         { buffer = true })
  end,
})

-- ============================================
-- Coding layout (call with :Coding)
-- Opens: NvimTree | editor | ClaudeCode
--                    terminal (below editor)
-- ============================================
vim.api.nvim_create_user_command("Coding", function()
  vim.cmd("NvimTreeOpen")
  vim.cmd("ClaudeCode")
  vim.cmd("wincmd h")   -- move to editor pane
  vim.cmd("split")
  vim.cmd("wincmd j")   -- move to new split below

  local shell = vim.fn.getenv("SHELL")
  if shell == vim.NIL or shell == "" then
    shell = "bash"
  end
  vim.cmd("terminal " .. shell)

  -- Set slime config to this terminal's job ID
  local jobid = vim.b.terminal_job_id
  vim.g.slime_default_config = { jobid = jobid }
  vim.g.slime_dont_ask_default = 1

  -- Also set it on the editor buffer above
  vim.cmd("wincmd k")
  vim.b.slime_config = { jobid = jobid }
end, {})
