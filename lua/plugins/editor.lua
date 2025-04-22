return {
  -- color theme
  {
    "catppuccin/nvim",
    opts = {
      integrations = {
        blink_cmp = true,
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        mason = true,
        markdown = true,
        telescope = {
          enabled = true,
        },
        lsp_trouble = true,
      },
    },
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme catppuccin-mocha]])
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "catppuccin-mocha",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
    },
    event = "BufEnter",
  }, -- fancier statusline

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  }, -- Add indentation guides even on blank lines

  { "tpope/vim-sleuth", event = "BufRead" }, -- Detect tabstop and shiftwidth automatically

  {
    "akinsho/bufferline.nvim", -- for file tabs
    config = function()
      require("bufferline").setup({
        options = {
          mode = "tabs",
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or ""
            return " " .. icon .. count
          end,
        },
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
      })
    end,
    event = "BufEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  { "numToStr/Comment.nvim", event = "BufRead", opts = {} }, -- "gc" to comment visual regions/lines (or "gcc" in normal)

  { "sbdchd/neoformat", event = "BufRead" }, -- code formatter
  { "windwp/nvim-autopairs", event = "BufRead", opts = {} }, -- autopairs
  { "windwp/nvim-ts-autotag", event = "BufRead", opts = {} }, -- autotag (autocomplete and autorename html/jsx/tsx tags)

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local status, telescope = pcall(require, "telescope")
      if not status then
        return
      end

      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          preview = false,
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
        pickers = {
          find_files = {
            -- theme = "ivy",
            hidden = true,
            find_command = {
              "rg",
              "--files",
              "--color=never",
              "--no-heading",
              "--line-number",
              "--column",
              "--smart-case",
              "--hidden",
              "--glob",
              "!{.git/*,.svelte-kit/*,target/*,node_modules/*}",
              "--path-separator",
              "/",
            },
          },
        },
        extensions = {
          file_browser = {
            initial_mode = "normal",
            -- theme = "dropdown",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {},
          },
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(telescope.load_extension, "fzf")

      -- telescope file browser
      telescope.load_extension("file_browser")

      -- telescope menufacture
      telescope.load_extension("menufacture")
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },

  -- telescope file browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  -- telescope m[e]nufacture (telescope extension)
  { "molecule-man/telescope-menufacture" },

  -- colorizer
  { "norcalli/nvim-colorizer.lua", event = "BufRead", opts = {} },

  -- discord presence, :DiscordPresence to load (it's a custom command created in devpandaz/init.lua)
  {
    "andweeb/presence.nvim",
    cmd = "DiscordPresence",
    opts = {
      neovim_image_text = "hacking",
    },
  },

  -- zen mode
  { "folke/zen-mode.nvim", cmd = { "ZenMode" } },

  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    cmd = { "MarkdownPreview" },
  },

  -- trouble.nvim
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle" },
  },

  -- nvim-transparent
  {
    "xiyaowong/nvim-transparent",
    cmd = { "TransparentEnable", "TransparentToggle" },
    opts = {
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
    },
  },

  -- github copilot
  { "github/copilot.vim", cmd = "Copilot" },

  -- oil.nvim
  {
    "stevearc/oil.nvim",
    opts = {
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
      },
      delete_to_trash = true,
    },
  },
}
