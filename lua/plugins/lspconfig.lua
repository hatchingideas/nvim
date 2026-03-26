return {
  "neovim/nvim-lspconfig",
  config = function()
    -- new API for nvim-lspconfig 0.11+
    vim.lsp.config("pyright", {})
    vim.lsp.enable("pyright")

    vim.lsp.config("r_language_server", {})
    vim.lsp.enable("r_language_server")

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            library = { vim.env.VIMRUNTIME },
            checkThirdParty = false,
          },
        },
      },
    })
    vim.lsp.enable("lua_ls")
  end,
}
