-- Basic Settings
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

-- Colorscheme
vim.opt.termguicolors = true  
vim.o.background  = "dark"       -- Enable true color support
vim.cmd.colorscheme = "gruvbox"    -- Set colorscheme (you can change this)

-- Keybindings
vim.keymap.set('n', '<leader>w', ':w<CR>')  -- Save file with <leader>w
vim.keymap.set('n', '<leader>q', ':q<CR>')  -- Quit Neovim with <leader>q

-- Plugin Management (Packer)
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

-- Autocommand to reload Packer when init.lua is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Initialize Packer
return require('packer').startup(function(use)
  -- Packer itself
  use 'wbthomason/packer.nvim'

  -- File explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- Optional: for file icons
    },
    config = function()
      -- Configure nvim-tree to open on the right
      require("nvim-tree").setup({
        view = {
          side = "right", -- Set the file explorer to open on the right
          width = 30,     -- Adjust the width as needed
        },
      })

      -- Open nvim-tree automatically when Neovim starts (optional)
      local api = require("nvim-tree.api")
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          api.tree.open()
        end,
      })
    end
  }

  -- Syntax highlighting
  use 'nvim-treesitter/nvim-treesitter'

  -- Statusline
  use 'nvim-lualine/lualine.nvim'

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    }
  }

  -- LSP (Language Server Protocol)
  use 'neovim/nvim-lspconfig'

  -- Git integration
  use 'lewis6991/gitsigns.nvim'

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- Automatically install missing parsers
  if packer_bootstrap then
    require('packer').sync()
  end
end)