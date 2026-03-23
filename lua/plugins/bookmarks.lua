-- Numbered bookmarks: m1-m9 to set, <leader>1-9 to jump, <leader>m to browse
-- Uses marks a-i internally. Avoids '1-'9 which are reserved shada marks in Neovim.

return {
  {
    "chentoast/marks.nvim",
    event = "BufReadPost",
    config = function()
      require("marks").setup({
        default_mappings = false,
        signs = true,              -- show bookmark number in the sign column
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        bookmark_0 = { sign = "⚑", virt_text = "" },
      })

      -- m1-m9: set bookmark, <leader>1-9: jump to bookmark
      local slots = { "a", "b", "c", "d", "e", "f", "g", "h", "i" }
      for i, letter in ipairs(slots) do
        vim.keymap.set("n", "m" .. i, "m" .. letter,
          { desc = "Set bookmark " .. i })
        vim.keymap.set("n", "<leader>" .. i, "'" .. letter,
          { desc = "Jump to bookmark " .. i })
      end

      -- <leader>m: floating menu via Telescope
      vim.keymap.set("n", "<leader>m", "<cmd>Telescope marks<cr>",
        { desc = "Browse bookmarks" })

      -- dm + digit: delete a numbered bookmark
      for i, letter in ipairs(slots) do
        vim.keymap.set("n", "dm" .. i, function()
          vim.cmd("delmark " .. letter)
          vim.notify("Bookmark " .. i .. " deleted", vim.log.levels.INFO)
        end, { desc = "Delete bookmark " .. i })
      end
    end,
  },
}
