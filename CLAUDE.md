# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Neovim configuration (`~/.config/nvim` equivalent on Windows: `AppData/Local/nvim`). Plugin management uses Neovim's **built-in `vim.pack`** (Nvim 0.12+). Each plugin lives in its own `plugin/<name>.lua` file that calls `vim.pack.add({ ... })` and then configures the plugin. The entry point is `init.lua`.

> **History:** this config was migrated from lazy.nvim to `vim.pack`. The
> `lua/plugins/*.lua` files are now inert stubs (`return {}` with a "migrated"
> comment) and the `lua/config/*.lua` files are **not loaded** by anything —
> both are legacy leftovers, not the active config. `lazy-lock.json` is
> likewise stale. Edit `plugin/*.lua` and `init.lua` only.

## Architecture

- **`init.lua`** — All in one: leader key, vim options, keymaps, and custom commands (`:Coding`, `:CodingClose`). No plugin-manager bootstrap.
- **`plugin/`** — Neovim auto-sources every `plugin/*.lua` on startup. Each file installs its plugin via `vim.pack.add(...)`, calls `vim.loader.reset()`, then runs the plugin's `setup()` and any related keymaps. Files load in alphabetical order, so the colorscheme uses a `00-` prefix to load first.
- **`nvim-pack-lock.json`** — `vim.pack` lockfile (managed by `vim.pack`).
- **`lazy-lock.json`, `lua/plugins/`, `lua/config/`** — legacy/unused (see note above).

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

Create a new file `plugin/<name>.lua`. Neovim auto-sources it on startup. Install with `vim.pack.add` then configure. Example:

```lua
vim.pack.add({
  { src = 'https://github.com/author/plugin-name', name = 'plugin-name' },
})
vim.loader.reset()
require('plugin-name').setup({})
```

Notes:
- Use the `{ src = ..., name = ... }` form when you want a specific local name (e.g. to avoid a `.nvim` suffix); a bare URL string also works.
- List dependencies before the plugin that needs them in the same `vim.pack.add` call (e.g. `nvim-web-devicons` before `bufferline`, `snacks.nvim` before `claudecode.nvim`).
- Theming via Catppuccin integrations is enabled in `plugin/00-catppuccin.lua` (`integrations = { ... }`).

## Theme

Catppuccin Mocha (dark). Loaded at priority 1000.
