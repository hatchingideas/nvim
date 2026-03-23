-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Core config (must load before plugins)
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Auto-discover all lua/plugins/*.lua files
require("lazy").setup("plugins", {
  change_detection = { notify = false },
})
