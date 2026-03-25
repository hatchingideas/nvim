return {
  -- Auto-close brackets, quotes, etc.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- gcc: toggle line comment, gc: toggle selection comment
  {
    "numToStr/Comment.nvim",
    config = true,
  },

  -- Vertical indent guides (especially useful for Python)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true,
  },

  -- ysiw" wraps word in quotes, cs"' changes quotes, ds( removes parens
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },

  -- s + 2 chars to jump anywhere on screen; S for treesitter-aware jump
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = true,
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,            desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,       desc = "Flash treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,            desc = "Flash remote" },
      { "<C-s>", mode = { "c" },       function() require("flash").toggle() end,            desc = "Flash search toggle" },
    },
  },

  -- Highlights TODO / FIXME / NOTE / HACK / WARN in comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
}
