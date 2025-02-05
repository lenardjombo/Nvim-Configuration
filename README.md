# Neovim Configuration

This is a basic Neovim configuration with essential settings, keybindings, and plugin management using Packer.

## Features
- Line numbers (relative and absolute)
- Spaces instead of tabs with smart indentation
- Mouse support and system clipboard integration
- Gruvbox colorscheme
- Convenient keybindings for saving and quitting
- Plugin management with Packer
- File explorer (`nvim-tree`)
- Syntax highlighting (`nvim-treesitter`)
- Statusline (`lualine`)
- Autocompletion (`nvim-cmp`)
- LSP support (`nvim-lspconfig`)
- Git integration (`gitsigns`)
- Fuzzy finder (`telescope`)

## Basic Settings
```lua
vim.opt.number = true                -- Show line numbers
vim.opt.relativenumber = true        -- Show relative line numbers
vim.opt.tabstop = 4                  -- Number of spaces for a tab
vim.opt.shiftwidth = 4               -- Number of spaces for indentation
vim.opt.expandtab = true             -- Use spaces instead of tabs
vim.opt.smartindent = true           -- Smart indentation
vim.opt.wrap = false                 -- Disable line wrapping
vim.opt.cursorline = true            -- Highlight the current line
vim.opt.mouse = 'a'                  -- Enable mouse support
vim.opt.clipboard = 'unnamedplus'    -- Use system clipboard
```

## Colorscheme
```lua
vim.opt.termguicolors = true  
vim.o.background  = "dark"       -- Enable true color support
vim.cmd.colorscheme = "gruvbox"    -- Set colorscheme (you can change this)
```

## Keybindings
```lua
vim.keymap.set('n', '<leader>w', ':w<CR>')  -- Save file with <leader>w
vim.keymap.set('n', '<leader>q', ':q<CR>')  -- Quit Neovim with <leader>q
```

## Plugin Management with Packer

### Ensure Packer is Installed
```lua
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()
```

### Auto-Reload Packer when Config is Saved
```lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])
```

### Plugin Setup
```lua
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'  -- Packer itself
  use 'nvim-tree/nvim-tree.lua' -- File explorer
  use 'nvim-treesitter/nvim-treesitter' -- Syntax highlighting
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'hrsh7th/nvim-cmp' -- Autocompletion
  use 'neovim/nvim-lspconfig' -- LSP
  use 'lewis6991/gitsigns.nvim' -- Git integration
  use 'nvim-telescope/telescope.nvim' -- Fuzzy finder
  if packer_bootstrap then require('packer').sync() end
end)
```

## File Explorer (`nvim-tree`)
```lua
require("nvim-tree").setup({
  view = {
    side = "right", -- Open on the right
    width = 30,
  },
})

-- Auto-open nvim-tree on startup
local api = require("nvim-tree.api")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    api.tree.open()
  end,
})
```

## Installation
1. Install Neovim
2. Install Packer:
   ```sh
   git clone --depth 1 https://github.com/wbthomason/packer.nvim \
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   ```
3. Copy this configuration into your `init.lua`
4. Open Neovim and run `:PackerSync` to install plugins

## License
MIT License

