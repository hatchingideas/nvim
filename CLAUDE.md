# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Neovim configuration (`~/.config/nvim` equivalent on Windows: `AppData/Local/nvim`). Plugin management uses **lazy.nvim** with plugin specs in `lua/plugins/*.lua` (one file per plugin or group). The entry point is `init.lua`.

## Architecture

- **`init.lua`** — All in one: leader key, lazy.nvim bootstrap, vim options, keymaps, and custom commands (`:Coding`, `:CodingClose`).
- **`lua/plugins/`** — Each file returns a lazy.nvim plugin spec table. Lazy auto-discovers all files in this directory via `require("lazy").setup("plugins")`.
- **`lazy-lock.json`** — Lockfile for plugin versions. Do not edit manually.

## Key Design Decisions

- **Leader is Space.** Both `mapleader` and `maplocalleader` are set to `" "`.
- **`:Coding` layout** — A custom command that opens a 4-pane layout: NvimTree (left) | editor (center-top) | terminal (center-bottom) | Claude Code (right). vim-slime is auto-wired to the terminal's job ID so `<C-x>` sends code there.
- **LSP uses nvim-lspconfig 0.11+ API** (`vim.lsp.config` / `vim.lsp.enable`), not the older `lspconfig.server.setup()` pattern.
- **Completion via blink.cmp** (not nvim-cmp). Sources: LSP > path > snippets > buffer.
- **vim-slime target is `"neovim"`** (built-in terminal), not tmux.
- **Autoread on focus** — An autocmd calls `checktime` on `FocusGained`/`BufEnter`/`CursorHold` so files edited externally (e.g., by Claude Code CLI) are reloaded automatically.

## Languages Supported

- **Python** — Pyright LSP, nvim-dap with debugpy, Treesitter
- **R** — r_language_server LSP, R.nvim (REPL integration), filetype-scoped `<leader>r*` keymaps
- **Lua, Markdown, Vim, Vimdoc** — Treesitter parsers installed

## Adding a New Plugin

Create a new file `lua/plugins/<name>.lua` returning a lazy.nvim spec table. It will be auto-loaded. Example:

```lua
return {
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({})
  end,
}
```

## Theme

Catppuccin Mocha (dark). Loaded at priority 1000.
