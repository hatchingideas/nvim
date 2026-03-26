return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "python", "r", "lua", "markdown", "vim", "vimdoc" },
    highlight = { enable = true },
  },
}
