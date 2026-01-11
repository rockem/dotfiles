# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a **Neovim configuration** using lazy.nvim as the plugin manager. The configuration follows a modular structure with clear separation of concerns:

- **Entry point**: `init.lua` → loads `rockem.config`
- **Core config**: `lua/rockem/config/` (keymaps, options, lazy bootstrap)
- **Plugins**: `lua/rockem/plugins/` (one file per plugin, auto-discovered)
- **Shared utilities**: `lua/rockem/plugins/common/` (e.g., lsp-attach.lua)

### Key Patterns

1. **Plugin Auto-Discovery**: lazy.nvim automatically imports all files from `lua/rockem/plugins/`
2. **Lazy Loading**: Most plugins load on events (`BufReadPre`, `InsertEnter`) or commands
3. **Shared LSP Config**: LSP keybindings centralized in `lua/rockem/plugins/common/lsp-attach.lua`
4. **Modern Neovim API**: Uses Neovim 0.11+ built-in LSP methods (`vim.lsp.enable()`, `vim.lsp.config()`)

## Plugin Management

### Adding a New Plugin

Create a new file in `lua/rockem/plugins/plugin-name.lua`:

```lua
return {
  "author/plugin-name",
  event = "VeryLazy",  -- or appropriate lazy-load trigger
  dependencies = { "required/dependency" },
  config = function()
    require("plugin-name").setup({
      -- configuration
    })
  end,
}
```

**Common lazy-load triggers**:

- `event = "BufReadPre"` - Load when reading buffers
- `event = "InsertEnter"` - Load when entering insert mode
- `cmd = "CommandName"` - Load when command is executed
- `lazy = false` - Load immediately (for critical plugins)

## LSP Configuration

### Adding LSP for a New Language

1. **Add to mason.lua**: Include server in `ensure_installed` list
2. **Enable in lspconfig.lua**: Add `vim.lsp.enable("server_name")`
3. **Custom config (optional)**: Use `vim.lsp.config("server_name", { settings = {...} })`

LSP keybindings automatically attach via the `LspAttach` autocmd → `common/lsp-attach.lua`.

### LSP Architecture

- **mason.nvim**: Installs LSP servers, formatters, linters
- **mason-lspconfig**: Bridges mason to nvim-lspconfig
- **lspconfig.lua**: Configures LSP servers using Neovim 0.11+ API
- **lsp-attach.lua**: Shared keybindings for all LSP clients

**Current LSP servers**: lua_ls, pyright, ruff, astro, ts_ls, ocamllsp, rust_analyzer

### LSP Keybindings (Buffer-local)

Set in `lua/rockem/plugins/common/lsp-attach.lua`:

- `gR` - References
- `gd` - Definition
- `gD` - Declaration
- `gi` - Implementation
- `gt` - Type definition
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>d` - Line diagnostics
- `<leader>D` - Buffer diagnostics
- `<leader>rs` - Restart LSP

## Formatting

Handled by **conform.nvim** (`lua/rockem/plugins/formatting.lua`):

- **Auto-format on save**: Enabled (5s timeout)
- **Manual format**: `<leader>cf`

**Formatters by language**:

- YAML/Markdown/JSON → prettier
- Lua → stylua (config: `.stylua.toml`, column_width=100)
- Python → isort + black

To add a formatter: Add to `formatters_by_ft` in formatting.lua, ensure tool installed via mason.

## Completion System

**Architecture** (`lua/rockem/plugins/nvim-cmp.lua`):

- Engine: nvim-cmp
- Snippet engine: LuaSnip
- Sources (priority): copilot → nvim_lsp → luasnip → buffer → path

**Keybindings**:

- `<C-j>/<C-k>` - Navigate suggestions
- `<C-Space>` - Trigger completion
- `<CR>` - Confirm (no auto-select)

## Testing & Debugging

### Testing (Neotest)

- Adapter: neotest-dart for Flutter
- Config: `lua/rockem/plugins/neotest.lua`

### Debugging (nvim-dap)

- Config: `lua/rockem/plugins/debugging.lua`
- Keybindings:
  - `<leader>dt` - Toggle breakpoint
  - `<leader>dc` - Continue/start debugging

## Keybinding Organization

### Global Keybindings

Defined in `lua/rockem/config/keymaps.lua`:

**Leaders**: `<Space>` for both leader and localleader

**Key groups**:

- `<leader>l` - Lazy plugin manager
- `<leader>e` - File explorer (nvim-tree)
- `<leader>f` - Fuzzy find (Telescope): `ff` files, `fr` recent, `fg` grep, `fc` config, `fb` buffers
- `<leader>g` - Git: `gp` preview hunk, `gb` blame
- `<leader>U` - Undo tree
- `<leader>R` - Registers
- `<C-Tab>` - Toggle last buffer

### Adding Keybindings

- **Global**: Add to `lua/rockem/config/keymaps.lua`
- **LSP**: Add to `lua/rockem/plugins/common/lsp-attach.lua`
- **Plugin-specific**: Add in plugin's config function
- **Group labels**: Update which-key spec in `lua/rockem/plugins/which-key.lua`

## File Structure Reference

```
/Users/e137126/.config/nvim/
├── init.lua                           # Entry point
├── lazy-lock.json                     # Plugin version locks
├── .stylua.toml                       # Lua formatter config
└── lua/rockem/
    ├── config/
    │   ├── init.lua                  # Loads keymaps, options, lazy
    │   ├── keymaps.lua               # Global keybindings
    │   ├── options.lua               # Vim options/settings
    │   └── lazy.lua                  # Plugin manager bootstrap
    └── plugins/
        ├── common/
        │   └── lsp-attach.lua        # Shared LSP keybindings
        ├── lspconfig.lua             # LSP server configuration
        ├── mason.lua                 # LSP/tool installer
        ├── formatting.lua            # Format-on-save config
        ├── nvim-cmp.lua              # Completion engine
        ├── nvim-treesitter.lua       # Syntax highlighting
        ├── telescope.lua             # Fuzzy finder
        ├── debugging.lua             # DAP configuration
        ├── neotest.lua               # Testing framework
        └── [other plugin configs]
```

## Common Tasks

### Restart Neovim Config

After editing config files:

1. Source the file: `:source %` (if in the file)
2. Or restart Neovim: `:qa` then reopen

### Check LSP Status

- `:LspInfo` - View attached LSP clients
- `:Mason` - View installed tools
- `<leader>rs` - Restart LSP for current buffer

### Format Code

- Auto-formats on save (if formatter configured)
- Manual: `<leader>cf`

### Search Codebase

- Find files: `<leader>ff`
- Live grep: `<leader>fg`
- Recent files: `<leader>fr`
- Config files: `<leader>fc`

## Important Notes

- **Personal namespace**: All Lua modules under `rockem.*` (not a standard name)
- **Lazy loading**: Most plugins won't load until needed - improves startup time
- **Auto-save**: Enabled via auto-save.nvim plugin
- **Treesitter**: 18+ languages configured for syntax highlighting
- **Git integration**: gitsigns.nvim for inline git status
