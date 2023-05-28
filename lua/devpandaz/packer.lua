local status, packer = pcall(require, 'packer')
if (not status) then
  print('Packer is not installed')
  return
end

require('packer').startup(function(use)
  -- packer manager
  use 'wbthomason/packer.nvim'

  -- impatient (faster startup time)
  use 'lewis6991/impatient.nvim'

  -- LSP Configuration & Plugins
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  -- lspkind
  use {
    'onsails/lspkind.nvim',
    event = 'BufRead',
    config = function() require('devpandaz.plugin.lazyload.lspsaga') end
  }

  -- autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  -- lspsaga
  use {
    "glepnir/lspsaga.nvim",
    event = "BufRead", --lazy load on BufRead
    
    -- note: 'setup' is executed before the plugin loads
    -- if the first file opened is a dart file, then before lspsaga loads, flutter-tools must load first
    -- if not, just load lspsaga as usual, and flutter-tools would be loaded whenever a dart file is opened, using ft = 'dart' (see flutter-tools section)
    setup = function() if (vim.bo.filetype == 'dart') then vim.cmd[[PackerLoad flutter-tools.nvim]] end end, 

    branch = "main",
    
    config = function()
      require('devpandaz.plugin.lazyload.lspsaga')
    end,

    requires = {
      {"nvim-tree/nvim-web-devicons"},
      {"nvim-treesitter/nvim-treesitter"}
    },
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use 'nvim-treesitter/nvim-treesitter-context' -- show code context as you scroll

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  -- themes
  use "ellisonleao/gruvbox.nvim"
  use 'rebelot/kanagawa.nvim'
  use 'folke/tokyonight.nvim'

  -- editor utils
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use { 'akinsho/bufferline.nvim', -- for file tabs
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons'
  }
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines (or "gcc" in normal)
  use 'sbdchd/neoformat' -- code formatter
  use { "windwp/nvim-autopairs" } -- autopairs
  use { 'windwp/nvim-ts-autotag' } -- autotag (autocomplete and autorename html/jsx/tsx tags)

  -- telescope
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

  -- telescope file browser
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }
  
  -- telescope m[e]nufacture (telescope extension)
  use { 'molecule-man/telescope-menufacture' }

  -- flutter-tools
  use {
    'akinsho/flutter-tools.nvim',
    ft = 'dart',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require('devpandaz.plugin.lazyload.flutter-tools') end
  }

  -- colorizer
  use 'norcalli/nvim-colorizer.lua'

  -- discord presence, :DiscordPresence to load (it's a custom command created in devpandaz/init.lua)
  use {'andweeb/presence.nvim', opt = true, config = function()
    print('discord presence enabled')
    require('devpandaz.plugin.lazyload.presence')
  end}

  -- zen mode
  use { "folke/zen-mode.nvim", cmd = { 'ZenMode' }}

  -- markdown preview
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
    cmd = { "MarkdownPreview" },
  })

  -- trouble.nvim
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require('devpandaz.plugin.lazyload.trouble')
    end,
    cmd = { 'Trouble', 'TroubleToggle' },
  }

  -- nvim-transparent
  use { "xiyaowong/nvim-transparent",
    cmd = { 'TransparentEnable', 'TransparentToggle' },
    config = function()
      require('devpandaz.plugin.lazyload.transparent')
    end
  }

  -- github copilot
  use {"github/copilot.vim", cmd = 'Copilot'}

end)
