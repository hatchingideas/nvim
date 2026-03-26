return {
  "jpalardy/vim-slime",
  config = function()
    vim.g.slime_target = "neovim"
    vim.g.slime_no_mappings = 1
    vim.g.slime_dont_ask_default = 1
    vim.g.slime_neovim_ignore_unlisted = 1
  end,
}
