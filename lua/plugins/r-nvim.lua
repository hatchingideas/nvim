return {
  "R-nvim/R.nvim",
  config = function()
    require("r").setup({
      R_args = {"--no-save", "--no-restore"},
      hook = {
        on_filetype = function()
          vim.keymap.set("n", "<Enter>", "<Plug>RDSendLine", { buffer = true })
          vim.keymap.set("v", "<Enter>", "<Plug>RDSendSelection", { buffer = true })
        end
      }
    })
  end,
}
