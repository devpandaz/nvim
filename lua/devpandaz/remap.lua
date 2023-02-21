-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

----- custom keymaps ------

-- to open terminal (powershell) from vim
vim.keymap.set('n', '<leader>ot', '<cmd>tabnew<cr><cmd>term pwsh<cr>i', { desc = '[O]pen [T]erminal (powershell)' })
-- to change to normal mode when in terminal mode to enable vim motions
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { desc = 'Escape to normal mode from terminal mode' })

-- navigating between windows
vim.keymap.set('n', '<leader>tj', '<c-w>j', { desc = '[T]o [j] Window Below' })
vim.keymap.set('n', '<leader>tk', '<c-w>k', { desc = '[T]o [j] Window Above' })
vim.keymap.set('n', '<leader>th', '<c-w>h', { desc = '[T]o [j] Window Left' })
vim.keymap.set('n', '<leader>tl', '<c-w>l', { desc = '[T]o [j] Window Right' })

-- copy and paste with system clipboard
vim.keymap.set('v', '<c-c>', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set('v', '<c-x>', '"+c', { desc = 'Cut' })
vim.keymap.set('v', '<c-v>', 'c<esc>"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('i', '<c-v>', '<esc>"+pa', { desc = 'Paste from system clipboard' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
