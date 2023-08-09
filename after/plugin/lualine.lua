local status, lualine = pcall(require, 'lualine')
if (not status) then return end

-- Set lualine as statusline
-- See `:help lualine.txt`

lualine.setup {
  options = {
    theme = 'catppuccin-mocha',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' }
  },
}
