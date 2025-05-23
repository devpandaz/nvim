-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- enable relative numbering
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
-- vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true
vim.o.background = "dark"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.python3_host_prog = "C:/Users/super/AppData/Local/Programs/Python/Python310/python.exe"

-- 'block' cursor in insert mode
vim.o.guicursor = "i:block"

vim.o.scrolloff = 999

-- hide lsp inline diagnostics
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true, -- for lspsaga to show inline diagnostics with <leader>e [https://github.com/nvimdev/lspsaga.nvim/issues/1520]
})
