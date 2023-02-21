-- Set lualine as statusline
-- See `:help lualine.txt`

-- nvim-navic for code context in lualine
local navic = require("nvim-navic")

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'gruvbox_dark',
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_c = {
      { navic.get_location, cond = navic.is_available },
    }
  }
}

