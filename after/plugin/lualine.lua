-- Set lualine as statusline
-- See `:help lualine.txt`

-- nvim-navic for code context in lualine
local navic = require("nvim-navic")

require('lualine').setup {
  options = {
    theme = 'gruvbox_dark',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' }
  },
  sections = {
    lualine_c = {
      { navic.get_location, cond = navic.is_available },
    }
  }
}
