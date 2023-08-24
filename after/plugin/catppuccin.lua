local status, catppuccin = pcall(require, 'catppuccin/nvim')
if (not status) then return end

catppuccin.setup({
    integrations = {
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
    }
})
