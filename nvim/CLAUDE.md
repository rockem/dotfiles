# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

A **Neovim 0.12+ configuration** using the built-in **`vim.pack`** plugin manager (not lazy.nvim). Plugins are pinned in `nvim-pack-lock.json`.

- **Entry point**: `init.lua` → `rockem.config` (`lua/rockem/config/init.lua`)
- **Load order**: `keymaps` → `options` → `pack`
- **Plugin loader**: `lua/rockem/config/pack.lua` — registers build hooks, then `require`s each plugin file **explicitly, in dependency order**
- **Plugins**: `lua/rockem/plugins/<name>.lua` — one file per plugin: `vim.pack.add({...})` followed by its setup and keymaps
- **Shared utilities**: `lua/rockem/plugins/common/lsp-attach.lua`
- **Custom vim-test runner**: `autoload/test/swift/xcodetest.vim`

All Lua modules live under the personal `rockem.*` namespace.

## Plugin Management

### Adding a plugin

1. Create `lua/rockem/plugins/plugin-name.lua`:

```lua
vim.pack.add({ "https://github.com/author/plugin-name" })
require("plugin-name").setup({})
```

2. **Add `require("rockem.plugins.plugin-name")` to `lua/rockem/config/pack.lua`** — files are NOT auto-discovered. An unlisted file never loads.
3. Pin versions with `{ src = "...", version = "tag" | vim.version.range(">=1,<2") | branch }` where needed.
4. If the plugin needs a build step, add a branch to the `PackChanged` autocmd in `pack.lua`.

`pack.lua` wraps `vim.pack.add` to pass `confirm = false` (no install prompt). There is no lazy loading: every plugin loads at startup.

Update with `:lua vim.pack.update()`; inspect with `:lua vim.pack.get()`.

## LSP

- **mason.nvim** installs servers and tools (`mason.lua`: `ensure_installed` for servers, `mason-tool-installer` for formatters/linters/debug adapters).
- **Servers are enabled explicitly** in `lspconfig.lua` via `vim.lsp.enable(...)`; per-server settings use `vim.lsp.config(...)`.
- Currently enabled: lua_ls, ts_ls, astro, basedpyright, ruff, zls, sourcekit.
- Rust is handled by **rustaceanvim** and Dart/Flutter by **flutter-tools**, not by `vim.lsp.enable`.
- Buffer-local LSP keymaps live in `common/lsp-attach.lua` (attached via `LspAttach`; flutter-tools reuses the same `on_attach`).

To add a language: add the server to `mason.lua`, then `vim.lsp.enable("name")` in `lspconfig.lua`.

### LSP keymaps (buffer-local)

`gR` references (Telescope), `gd` definition, `gD` declaration, `gi` implementations, `gt` type definitions, `K` hover, `<leader>ca` code action, `<leader>rn` rename, `<leader>cd` line diagnostics, `<leader>D` buffer diagnostics, `<leader>rs` restart LSP.

## Formatting & Linting

- **conform.nvim** (`formatting.lua`): format on save (`lsp_format = "fallback"`, 5s timeout); manual `<leader>cf`. Formatters by filetype: prettier (yaml/markdown/json/js/ts/astro/svelte), stylua (lua, config in `.stylua.toml`), isort+black (python), rustfmt, zigfmt, swiftformat.
- **nvim-lint** (`linting.lua`): markdownlint, eslint_d; runs only if the linter executable exists. Manual `<leader>cl`.

## Completion

nvim-cmp (`nvim-cmp.lua`) with LuaSnip + friendly-snippets. Sources: nvim_lsp, luasnip, buffer, dictionary, path. Copilot is separate: copilot.lua inline ghost text (`<Tab>` accept, `<M-w>` word, `<M-]>`/`<M-[>` cycle, `<C-]>` dismiss). Keys: `<C-j>/<C-k>` navigate, `<C-Space>` trigger, `<CR>` confirm (no auto-select), `<C-e>` abort.

## Testing & Debugging

- **vim-test** (`vim-test.lua`): `<leader>tt` nearest, `tf` file, `ta` suite, `tl` last, `tv` visit. Strategy `neovim_sticky`; cargo-nextest transform; Swift uses the custom `XcodeTest` runner or SwiftPM.
- **nvim-dap + dap-ui** (`debugging.lua`): `<leader>dt` breakpoint, `<leader>dc` continue, `<leader>du` toggle UI. Dart adapter configured in `flutter-tools.lua`.

## Markdown

- **render-markdown.nvim** renders markdown in-buffer.
- **diagram.nvim + image.nvim** (`diagram.lua`) render mermaid blocks as images via `mmdc` and the kitty graphics protocol (Ghostty). Requires `mmdc` and `magick` on PATH. Auto-renders on `InsertLeave`/`BufWinEnter`; `<leader>md` opens the diagram under the cursor in its own tab.

## Other keymaps

Leader and localleader are `<Space>`. Global maps are in `config/keymaps.lua`; plugin maps live in each plugin file. Update `which-key.lua` group labels when adding a new `<leader>` prefix.

- `<leader>e` nvim-tree
- `<leader>f` Telescope: `ff` files, `fr` recent, `fg` grep, `fc` config, `fb` buffers
- `<leader>g` git: `gp` preview hunk, `gb` blame, `gd`/`gh`/`gH`/`gq` Diffview, `gc` CodeDiff working tree, `gC` staged, `gm` branch vs main, `gf` file history, `gF` repo history (codediff.nvim, `codediff.lua`; downloads its diff library on first use)
- `<leader>h` harpoon
- `<leader>x` Trouble
- `<leader>s` treesitter swap
- `<leader>U` undo tree (Telescope), `<leader>R` registers, `<leader>cp` pre-commit
- `<C-Tab>` alternate buffer

## Notes

- Colorscheme: catppuccin (mocha). Sessions: auto-session. Statusline: lualine.
- Treesitter uses the `main` branch API (`require("nvim-treesitter").setup()` takes only `install_dir`); parsers install on startup and highlighting starts via a `FileType` autocmd.
- Neovim state/log files (`.nvimlog`) are git-ignored.
