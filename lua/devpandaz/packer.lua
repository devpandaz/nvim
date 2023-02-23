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
  use { 'onsails/lspkind.nvim' }

  -- autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
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
  use { -- navic (for code context)
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
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
  
  use { 'molecule-man/telescope-menufacture' }

  -- noice.nvim
  use{
    "folke/noice.nvim",
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  }

  -- ***** opt plugins *****

  -- discord presence
  use {'andweeb/presence.nvim', opt = true}

  -- zen mode
  use { "folke/zen-mode.nvim", opt = true }

  -- vim-startuptime
  use { "dstein64/vim-startuptime", opt = true, cmd = { 'StartupTime' } }

  -- markdown preview
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
    opt = true,
    cmd = { "MarkdownPreview" },
  })

  -- trouble.nvim
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require('trouble').setup()
    end,
    opt = true,
    cmd = { 'Trouble', 'TroubleToggle' },
  }

  -- nvim-transparent
  use { "xiyaowong/nvim-transparent",
    opt = true,
    cmd = { 'TransparentEnable', 'TransparentToggle' },
    config = function()
      require("transparent").setup({
        enable = true, -- boolean: enable transparent
        extra_groups = { -- table/string: additional groups that should be cleared
          -- In particular, when you set it to 'all', that means all available groups

          -- example of akinsho/nvim-bufferline.lua
          "BufferLineTabClose",
          "BufferlineBufferSelected",
          "BufferLineFill",
          "BufferLineBackground",
          "BufferLineSeparator",
          "BufferLineIndicatorSelected",
        },
        exclude = {}, -- table: groups you don't want to clear
      })
    end
  }

end)
