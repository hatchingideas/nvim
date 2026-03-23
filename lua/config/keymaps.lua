-- File explorer
vim.keymap.set("n", "<leader>e",  ":NvimTreeToggle<CR>")

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")   -- requires ripgrep: sudo apt install ripgrep
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")

-- Claude Code
vim.keymap.set("n", "<leader>cc", ":ClaudeCode<CR>")

-- Git
vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>")
vim.keymap.set("n", "<leader>gc", ":DiffviewClose<CR>")

-- Terminal (uses $SHELL on Linux instead of powershell)
vim.keymap.set("n", "<leader>tw", ":belowright split | terminal<CR>")
vim.keymap.set("n", "<leader>ty", ":belowright split | terminal python3 %<CR>")

-- Window navigation (normal mode)
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- Window navigation (terminal mode)
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")

-- DAP debugger
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end)
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end)
vim.keymap.set("n", "<leader>ds", function() require("dap").step_over() end)
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end)
vim.keymap.set("n", "<leader>do", function() require("dap").step_out() end)
vim.keymap.set("n", "<leader>du", function() require("dapui").toggle() end)

-- vim-slime: send to REPL
vim.keymap.set("v", "<C-x>", "<Plug>SlimeRegionSend", { desc = "Send selection to REPL" })
vim.keymap.set("n", "<C-x>", "<Plug>SlimeLineSend",   { desc = "Send line to REPL" })

-- Trouble: diagnostics panel
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              { desc = "Diagnostics (project)" })
vim.keymap.set("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnostics (buffer)" })
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>",                  { desc = "Symbols" })

-- Todo-comments: list TODOs in Telescope
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })

-- Conform: manual format
vim.keymap.set("n", "<leader>cf", function() require("conform").format({ async = true }) end, { desc = "Format file" })
