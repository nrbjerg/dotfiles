local fn = vim.fn

-- Bootstrapping from the packer wiki: https://github.com/wbthomason/packer.nvim#bootstrapping
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim"
  use { "ellisonleao/gruvbox.nvim" }
  -- UI: 
  use "shaunsingh/nord.nvim"
  use "nvim-lualine/lualine.nvim"
  use "nvim-treesitter/nvim-treesitter"
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }
  use "norcalli/nvim-colorizer.lua"
  
  -- Completions
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"

  -- Snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"

  -- LPS
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"

  -- Misc
  use "terrortylor/nvim-comment"
  use "lervag/vimtex"
  
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
