return {
  {
    "saghen/blink.cmp",
    enabled = false,
    event = "InsertEnter",
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets", "nvim-tree/nvim-web-devicons", "onsails/lspkind.nvim" },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },

      cmdline = {
        enabled = false,
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      completion = {
        list = {
          selection = { auto_insert = true },
        },
        documentation = {
          auto_show = true,
          treesitter_highlighting = true,
          window = {
            border = "single",
          },
        },
        menu = {
          border = "single",
          draw = {
            treesitter = { "lsp" },
            components = {
              kind_icon = {
                text = function(ctx)
                  local lspkind = require("lspkind")
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = require("lspkind").symbolic(ctx.kind, {
                      mode = "symbol",
                    })
                  end

                  return icon .. ctx.icon_gap
                end,

                -- Optionally, use the highlight groups from nvim-web-devicons
                -- You can also add the same function for `kind.highlight` if you want to
                -- keep the highlight groups in sync with the icons.
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },
            },
          },
        },
      },

      -- Experimental signature help support
      signature = {
        enabled = false,
        trigger = {
          -- Show the signature help automatically
          enabled = true,
          -- Show the signature help window after typing any of alphanumerics, `-` or `_`
          show_on_keyword = false,
          blocked_trigger_characters = {},
          blocked_retrigger_characters = {},
          -- Show the signature help window after typing a trigger character
          show_on_trigger_character = true,
          -- Show the signature help window when entering insert mode
          show_on_insert = false,
          -- Show the signature help window when the cursor comes after a trigger character when entering insert mode
          show_on_insert_on_trigger_character = true,
        },
        window = {
          min_width = 1,
          max_width = 100,
          max_height = 10,
          border = "single",
          winblend = 0,
          winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
          scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
          -- Which directions to show the window,
          -- falling back to the next direction when there's not enough space,
          -- or another window is in the way
          direction_priority = { "n", "s" },
          -- Disable if you run into performance issues
          treesitter_highlighting = true,
          show_documentation = true,
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },

  {
    "neovim/nvim-lspconfig",
    event = "BufEnter",
    dependencies = {
      -- "saghen/blink.cmp",
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing
      { "folke/neodev.nvim", opts = {} },
    },

    -- example using `opts` for defining servers
    -- opts = {
    --   servers = {
    --     -- lua_ls = {}
    --   },
    -- },

    config = function()
      lspconfig = require("lspconfig")

      -- LSP settings.
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
      end

      lspconfig.clangd.setup({
        on_attach = on_attach,
      })

      local servers = {
        -- lua_ls = {},
      }

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- blink.cmp
      -- for server, config in pairs(servers) do
      --   -- passing config.capabilities to blink.cmp merges with the capabilities in your
      --   -- `opts[server].capabilities, if you've defined it
      --   config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      --   lspconfig[server].setup(config)
      -- end

      -- Ensure the servers above are installed
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          })
        end,
      })
    end,
  },

  {
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        -- local lspkind = require("lspkind")

        cmp.setup({
          window = {
            completion = {
              border = "rounded",
            },
            documentation = {
              border = "rounded",
            },
          },
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            -- ['<C-j>'] = cmp.mapping.select_next_item(),
            -- ['<C-k>'] = cmp.mapping.select_prev_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
            ["<space>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<Esc>"] = cmp.mapping(function(fallback)
              cmp.mapping.close()
              vim.cmd([[stopinsert]])
            end),
          }),
          sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
          },
          formatting = {
            fields = { "abbr", "menu", "kind" },
            format = function(entry, item)
              -- Define menu shorthand for different completion sources.
              local menu_icon = {
                nvim_lsp = "NLSP",
                nvim_lua = "NLUA",
                luasnip = "LSNP",
                buffer = "BUFF",
                path = "PATH",
              }

              local kind_icons = {
                Text = "",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰇽",
                Variable = "󰂡",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
              }

              -- Kind icons
              item.kind = string.format("%s %s", kind_icons[item.kind], item.kind) -- This concatenates the icons with the name of the item kind

              -- Set the menu "icon" to the shorthand for each completion source.
              item.menu = menu_icon[entry.source.name]

              -- Set the fixed width of the completion menu to 60 characters.
              -- fixed_width = 20

              -- Set 'fixed_width' to false if not provided.
              fixed_width = fixed_width or false

              -- Get the completion entry text shown in the completion window.
              local content = item.abbr

              -- Set the fixed completion window width.
              if fixed_width then
                vim.o.pumwidth = fixed_width
              end

              -- Get the width of the current window.
              local win_width = vim.api.nvim_win_get_width(0)

              -- Set the max content width based on either: 'fixed_width'
              -- or a percentage of the window width, in this case 20%.
              -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
              local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

              -- Truncate the completion entry text if it's longer than the
              -- max content width. We subtract 3 from the max content width
              -- to account for the "..." that will be appended to it.
              if #content > max_content_width then
                item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
              else
                item.abbr = content .. (" "):rep(max_content_width - #content)
              end
              return item
            end,
          },
        })
      end,
    },
  },

  {
    "glepnir/lspsaga.nvim",
    event = "BufRead", --lazy load on BufRead

    -- note: 'init' is executed before the plugin loads
    -- if the first file opened is a dart file, then before lspsaga loads, flutter-tools must load first
    -- if not, just load lspsaga as usual, and flutter-tools would be loaded whenever a dart file is opened, using ft = 'dart' (see flutter-tools section)
    init = function()
      if vim.bo.filetype == "dart" then
        vim.cmd([[PackerLoad flutter-tools.nvim]])
      end
    end,

    config = function()
      require("lspsaga").setup({
        ui = {
          winblend = 10,
          border = "rounded",
          colors = {
            -- normal_bg = "#002b36",
          },
          kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        },
        symbol_in_winbar = {
          enable = false,
        },
      })
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- flutter-tools
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = {
      decorations = {
        statusline = {
          -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
          -- this will show the current version of the flutter app from the pubspec.yaml file
          app_version = true,
          -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
          -- this will show the currently running device if an application was started with a specific
          -- device
          device = true,
        },
      },
    },
  },

  -- rust tools to complement rust-analyzer
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
}
